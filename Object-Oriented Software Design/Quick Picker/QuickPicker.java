package edu.cuny.csi.csc330.lab6;

import edu.cuny.csi.csc330.util.Randomizer;

import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;
import java.util.stream.Collectors;

public class QuickPicker {

    private String PROP_FILE_NAME;

    // constants specific to current game - BUT NOT ALL GAMES
    public final static int DEFAULT_GAME_COUNT = 3;
    private final static int SELECTION_COUNT = 6;
    private final static int MINIMAL_LOTTO_NUMBER = 1;

    // keep track of how many games are going to be played
    private int gameCount;

    /*
     * The developer can still designate NonSupportedGameTypes by using string literals anyways.
     * I still think having this enum here is good thing just to ensure
     * correct file names are used.
     */
    public enum SupportedGames {
        PICK_10 {
            @Override
            public String getPropFileName() {
                return "pick10";
            }
        },
        MEGA_MILLIONS {
            @Override
            public String getPropFileName() {
                return "megamillions";
            }
        };
        public abstract String getPropFileName();
    }

    public class Pool {
        private int numbersNeeded;
        private int maxNumber;

        public Pool(String poolData) {
            this.numbersNeeded = Integer.parseInt(poolData.split("/")[0]);
            this.maxNumber = Integer.parseInt(poolData.split("/")[1]);
        }

        public int getNumbersNeeded() {
            return this.numbersNeeded;
        }

        public int getMaxNumber() {
            return this.maxNumber;
        }
    }

    public QuickPicker() {
        this.gameCount = DEFAULT_GAME_COUNT;
        this.PROP_FILE_NAME = SupportedGames.MEGA_MILLIONS.getPropFileName();
    }

    // This could also be used for use NonSupportedGameTypes
    public QuickPicker(int games, String propFileName) {
        this.gameCount = games;
        this.PROP_FILE_NAME = propFileName;
    }

    public QuickPicker(int games, SupportedGames game) {
        this.gameCount = games;
        this.PROP_FILE_NAME = game.getPropFileName();
    }

    private String generateTicket() throws QuickPickerException {
        List < String > ticket = new ArrayList < > ();
        // the game needs to generate a certain amount of numbers
        for (int i = 0; i < getPool1().getNumbersNeeded(); i++) {
            // generate a random int using randomizer
            int randomNumber = Randomizer.generateInt(MINIMAL_LOTTO_NUMBER, getPool1().getMaxNumber());
            // if value is a non double digit add a zero in front of it
            String val = randomNumber < 10 ? "0" + randomNumber : String.valueOf(randomNumber);
            // make sure the ticket is unique, if so go back an iteration and try another
            // one
            if (ticket.contains(val)) {
                i--;
                continue;
            }
            // if the above statement wasn't true add it to the ticket list
            ticket.add(val);
        }
        ticket = ticket.stream() // convert the ticket into a stream
            .sorted()
            .collect(Collectors.toList());

        ticket.add("|");

        List < String > pool = new ArrayList < > ();

        for (int i = 0; i < getPool2().getNumbersNeeded(); i++) {
            int randomNumber = Randomizer.generateInt(MINIMAL_LOTTO_NUMBER, getPool2().getMaxNumber());
            String val = randomNumber < 10 ? "0" + randomNumber : String.valueOf(randomNumber);
            if (pool.contains(val)) {
                i--;
                continue;
            }
            pool.add(val);
        }

        pool = pool.stream().sorted().collect(Collectors.toList());

        ticket.addAll(pool);

        return String.join(" ", ticket);
    }
    public void displayTicket() throws QuickPickerException {

        // display ticket heading
        displayHeading();
        // display selected numbers
        for (int i = 0; i < gameCount; i++) {
            System.out.println(" (" + (i + 1) + ") " + generateTicket());
        }
        // display ticket footer
        displayFooter();

    }

    protected void displayHeading() throws QuickPickerException {
        System.out.println("    ");
        System.out.println("-------------------------------------");
        System.out.println("    ------- " + getName() + "--------");
        System.out.println("        " + Instant.now().atZone(ZoneId.systemDefault())
            .format(DateTimeFormatter.ofLocalizedDateTime(FormatStyle.SHORT)));
    }

    protected void displayFooter() throws QuickPickerException {
        System.out.println("    ----" + getVendor() + "----");
        System.out.println("-------------------------------------");
    }

    public String getName() throws QuickPickerException {
        return getProperties().getString("GameName");
    }

    public String getVendor() throws QuickPickerException {
        return getProperties().getString("Vendor");
    }

    private ResourceBundle getProperties() throws QuickPickerException {
        ResourceBundle properties;
        try {
            properties = ResourceBundle.getBundle(PROP_FILE_NAME);
        } catch (Exception e) {
            throw new QuickPickerException(e.getMessage(), QuickPickerException.INVALID_GAME_NAME);
        }
        if (!properties.containsKey("GameName")) throw new QuickPickerException("GameName property missing", QuickPickerException.INVALID_PROPERTY_CODE);
        if (!properties.containsKey("Vendor")) throw new QuickPickerException("Vendor property missing", QuickPickerException.INVALID_PROPERTY_CODE);
        if (!properties.containsKey("Pool1")) throw new QuickPickerException("Pool1 property missing", QuickPickerException.INVALID_PROPERTY_CODE);
        if (!properties.containsKey("Pool2")) throw new QuickPickerException("Pool2 property missing", QuickPickerException.INVALID_PROPERTY_CODE);
        return properties;
    }

    public Pool getPool1() throws QuickPickerException {
        return new Pool(getProperties().getString("Pool1"));
    }

    public Pool getPool2() throws QuickPickerException {
        return new Pool(getProperties().getString("Pool2"));
    }

    public static void main(String[] args) throws QuickPickerException {
        // takes an optional command line parameter specifying number of QP games to be generated
        // By default, generate 1
        int numberOfGames = DEFAULT_GAME_COUNT;

        if (args.length > 0) { // if user provided an arg, assume it to be a game count
            numberOfGames = Integer.parseInt(args[0]); // [0] is the 1st element!
        }

        // Supported game types
        for (SupportedGames game: SupportedGames.values()) {
            QuickPicker lotto = new QuickPicker(numberOfGames, game);
            lotto.displayTicket();
        }

        // unsupported game types
        QuickPicker lotto2 = new QuickPicker(numberOfGames, "pick10");
        lotto2.displayTicket();
    }
}

package edu.cuny.csi.csc330.lab3;

import edu.cuny.csi.csc330.util.Randomizer;

import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.ArrayList;
import java.util.stream.Collectors;

public class LottoQuickPicker {

    // constants specific to current game - BUT NOT ALL GAMES
    public final static int DEFAULT_GAME_COUNT = 1;
    private final static String GAME_NAME = "Lotto";
    private final static int SELECTION_COUNT = 6;
    private final static int MINIMAL_LOTTO_NUMBER = 1;
    private final static int MAXIMUM_LOTTO_NUMBER = 59;

    // keep track of how many games are going to be played
    private int gameCount;

    public LottoQuickPicker() {
        init(DEFAULT_GAME_COUNT);
    }

    public LottoQuickPicker(int games) {
        init(games);
    }

    private void init(int games) {
        this.gameCount = games;
    }
    private String generateTicket() {
        ArrayList<String> ticket = new ArrayList<>();
        // the game needs to generate a certain amount of numbers
        for (int i = 0; i < SELECTION_COUNT; i++) {
            // generate a random int using randomizer
            int randomNumber = Randomizer.generateInt(MINIMAL_LOTTO_NUMBER, MAXIMUM_LOTTO_NUMBER);
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

        return ticket.stream() // convert the ticket into a stream
                .sorted() // sort it
                .collect(Collectors.joining(" ")); // collect it and join by spaces
    }
       public void displayTicket() {

        // display ticket heading
        displayHeading();
        // display selected numbers
        for (int i = 0; i < gameCount; i++) {
            System.out.println(" (" + (i + 1) + ") " + generateTicket());
        }
        // display ticket footer
        displayFooter();

    }

    protected void displayHeading() {
        System.out.println("----------------------------");
        System.out.println("-----------" + GAME_NAME + "------------");
        System.out.println("    " + Instant.now().atZone(ZoneId.systemDefault())
                .format(DateTimeFormatter.ofLocalizedDateTime(FormatStyle.SHORT)));
    }

    protected void displayFooter() {
        System.out.println("---- (c)S.I Corner Deli ----");
        System.out.println("----------------------------");
    }

    private long calculateOdds() {
        return 0;
    }
    public static void main(String[] args) {
        // takes an optional command line parameter specifying number of QP games to be
        // generated
        // By default, generate 1
        int numberOfGames = DEFAULT_GAME_COUNT;

        if (args.length > 0) { // if user provided an arg, assume it to be a game count
            numberOfGames = Integer.parseInt(args[0]); // [0] is the 1st element!
        }

        LottoQuickPicker lotto = new LottoQuickPicker(7);
        lotto.displayTicket();
    }
} 

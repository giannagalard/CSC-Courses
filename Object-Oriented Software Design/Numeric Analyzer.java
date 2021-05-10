package edu.cuny.csi.csc330.lab2;

import java.util.Arrays;
import java.lang.Math;

public class NumericAnalyzer implements Runnable {
    // empty constructor
    public NumericAnalyzer() {

    }

    public void run() {

    }

    // sort the unsorted arrays **PUT OUTPUT HERE**
    public void sortArray(int[] array) {
        Arrays.sort(array);
        // sort and output integer array
        
        display(array);
        System.out.printf("\n-----------------------------------------------------");
        System.out.printf("\n ");
        System.out.printf("\n%-50s %-10s%n", "Count:", array.length);
        System.out.printf("%-50s %-10s%n", "Min:", calcMin(array));
        System.out.printf("%-50s %-10s%n", "Max:", calcMax(array));
        System.out.printf("%-50s %-10s%n", "Range:", calcRange(array));
        System.out.printf("%-50s %-10s%n", "Sum:", calcSum(array));
        System.out.printf("%-50s %-10s%n", "Mean:", calcMean(array));
        System.out.printf("%-50s %-10s%n", "Median:", calcMedian(array));
        System.out.printf("%-50s %-10s%n", "Variance:", Math.round(calcVariance(array)));
        System.out.printf("%-50s %-10s%n", "Standard Deviation:", Math.round(calcSD(array)));
        System.out.printf("\n-----------------------------------------------------");
        return;
    }
    // calculate the min ( first element of array )
        public int calcMin(int[] numArray) {

            return numArray[0];
        }
        
    // calculate the max
    public int calcMax(int[] numArray) {
        return numArray[numArray.length - 1];
    }

    // calculate range using max and min
        public int calcRange(int[] numArray) {

            int max, min;
            max = calcMax(numArray);
            min = calcMin(numArray);
            return max - min;
        }
        
    // calculate the sum
    public int calcSum(int[] numArray) {
        int sum = 0;
        for (int number : numArray) {
            sum += number;
        }
        return sum;
    }

    // calculate the mean ( middle element or average of 2 )
    public int calcMean(int[] numArray) {
        int sum = 0, mean;
        sum = calcSum(numArray);
        mean = sum / numArray.length;
        return mean;
    }
        // calculate the median
    public int calcMedian(int[] numArray) {
        int median;
        if (numArray.length % 2 == 0) {
            median = (numArray[numArray.length / 2] + numArray[numArray.length / 2 - 1]) / 2;
        } else {
            median = numArray[numArray.length / 2];
        }
        return median;
    }


    // calculate variance (use math.pow)
    public double calcVariance(int[] numArray) {
        double variance = 0;
        int mean = calcMean(numArray);
        for (int number : numArray) {
            variance += Math.pow(number - mean, 2);
        }
        variance = variance / numArray.length;
        return variance;
    }

    // calculate standard deviation (use math.sqrt)
    public double calcSD(int[] numArray) {
        double variance = calcVariance(numArray);
        double stdDev = Math.sqrt(variance);
        return stdDev;

    }

    // displays the sorted array element by element
    public void display(int[] numArray) {
        // for all integers present in numArray print them
        for (int number : numArray) {
            System.out.print(number + "\t");
        }
    }

    public static void main(String[] args) {
        // if no user input, display error code and exit
        if (args.length == 0) {
            System.out.printf("ERROR - NO ARGUMENTS ENTERED");
            return;
        }
        // create array of same length if there are arguments
        int array[] = new int[args.length];
        // convert to ints and store elements into new array
        for (int i = 0; i < args.length; i++) {
            array[i] = Integer.parseInt(args[i]);
        }
        NumericAnalyzer numAnalyzer = new NumericAnalyzer();
        numAnalyzer.sortArray(array);
        return;

    }
}

import java.util.Scanner;

public class FCFS {
    public static void main(String[] args) {
        int i, j, n;
        int[] burst_time = new int[50];
        int[] arrival_time = new int[50];
        int[] waiting_time = new int[50];
        int[] turnaround_time = new int[50];
        int[] completion_time = new int[50];
        float avg_wait = 0, avg_TT = 0;

        Scanner s = new Scanner(System.in);
        System.out.print("Enter the number of processes: ");
        n = s.nextInt();

        // Input arrival and burst time
        System.out.println("\nEnter Arrival Time and Burst Time for each process:");
        for (i = 0; i < n; i++) {
            System.out.print("\tP" + (i + 1) + " Arrival Time: ");
            arrival_time[i] = s.nextInt();
            System.out.print("\tP" + (i + 1) + " Burst Time: ");
            burst_time[i] = s.nextInt();
        }

        // Sort processes by arrival time (FCFS rule)
        for (i = 0; i < n - 1; i++) {
            for (j = i + 1; j < n; j++) {
                if (arrival_time[i] > arrival_time[j]) {
                    int temp = arrival_time[i];
                    arrival_time[i] = arrival_time[j];
                    arrival_time[j] = temp;

                    temp = burst_time[i];
                    burst_time[i] = burst_time[j];
                    burst_time[j] = temp;
                }
            }
        }

        // Calculate completion, turnaround and waiting times
        completion_time[0] = arrival_time[0] + burst_time[0];
        turnaround_time[0] = completion_time[0] - arrival_time[0];
        waiting_time[0] = turnaround_time[0] - burst_time[0];

        for (i = 1; i < n; i++) {
            if (arrival_time[i] > completion_time[i - 1]) {
                // CPU idle time
                completion_time[i] = arrival_time[i] + burst_time[i];
            } else {
                completion_time[i] = completion_time[i - 1] + burst_time[i];
            }

            turnaround_time[i] = completion_time[i] - arrival_time[i];
            waiting_time[i] = turnaround_time[i] - burst_time[i];
        }

        // Calculate averages
        for (i = 0; i < n; i++) {
            avg_wait += waiting_time[i];
            avg_TT += turnaround_time[i];
        }
        avg_wait /= n;
        avg_TT /= n;

        // Output
        System.out.println("\n****************************************************************");
        System.out.println("    Process\tAT\tBT\tCT\tTAT\tWT");
        System.out.println("****************************************************************");
        for (i = 0; i < n; i++) {
            System.out.println("\tP" + (i + 1) + "\t" + arrival_time[i] + "\t" + burst_time[i] + "\t" +
                    completion_time[i] + "\t" + turnaround_time[i] + "\t" + waiting_time[i]);
        }
        System.out.println("\n----------------------------------------------------------------");
        System.out.printf("\nAverage Waiting Time : %.2f", avg_wait);
        System.out.printf("\nAverage Turn Around Time : %.2f\n", avg_TT);

        s.close();
    }
}

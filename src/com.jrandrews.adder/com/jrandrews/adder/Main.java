package com.jrandrews.adder;

public class Main {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("No args provided. For fun: 10 + 5 = 15");
            return;
        }

        int n = 0;
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < args.length; ++i) {
            try {
               n += Integer.valueOf(args[i]);
               result.append(args[i]).append(" + ");
            } catch (NumberFormatException e) {
                result.append(" ").append(args[i]).append(" ");
            }
        }

        if (result.lastIndexOf("+") < 0) {
            System.out.println(result.toString());

        } else {
            result.delete(result.lastIndexOf("+"), result.length());
            result.append("= ").append(n);

            System.out.println(result.toString());
        }
    }

}

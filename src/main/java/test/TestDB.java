package test;

import java.sql.Connection;
import java.sql.DriverManager;

public class TestDB {

    public static void main(String[] args) {
        try {
            Connection con = DriverManager.getConnection(
                "jdbc:h2:tcp://localhost/~/exam",
                "sa",
                ""
            );

            if (con != null) {
                System.out.println("H2 Connected Successfully!");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


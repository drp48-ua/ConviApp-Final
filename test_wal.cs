using System;
using System.Data.SQLite;

class Program {
    static void Main() {
        string cs = "Data Source=conviapp.db;Version=3;Journal Mode=WAL;";
        using (var c = new SQLiteConnection(cs)) {
            c.Open();
            using (var cmd = new SQLiteCommand("PRAGMA journal_mode;", c)) {
                Console.WriteLine(cmd.ExecuteScalar());
            }
        }
    }
}

package com.trionda.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * SINGLETON PATTERN
 * Menjamin hanya ada SATU instance DBConnectionManager
 * di seluruh siklus hidup aplikasi.
 *
 * Kenapa Singleton di sini?
 * - Koneksi database itu mahal (butuh waktu & resource)
 * - Kalau setiap DAO buat koneksi sendiri = boros & tidak terkontrol
 * - Singleton memastikan satu titik akses terpusat ke database
 */
public class DBConnectionManager {

    // SINGLETON: satu-satunya instance, disimpan sebagai
    // static field — hidup selama aplikasi berjalan
    private static DBConnectionManager instance;

    // Kredensial database, dibaca dari db.properties
    private String url;
    private String username;
    private String password;
    private String driver;

    // PRIVATE CONSTRUCTOR
    // Tidak boleh ada yang buat objek ini dengan "new"
    // dari luar class ini
    private DBConnectionManager() {
        loadProperties();
    }

    // getInstance() — satu-satunya pintu masuk
    // Thread-safe dengan synchronized
    public static synchronized DBConnectionManager getInstance() {
        if (instance == null) {
            instance = new DBConnectionManager();
        }
        return instance;
    }

    // -------------------------------------------------------
    // Baca kredensial dari db.properties di classpath
    // -------------------------------------------------------
    private void loadProperties() {
        Properties props = new Properties();
        try (InputStream input = getClass()
                .getClassLoader()
                .getResourceAsStream("db.properties")) {

            if (input == null) {
                throw new RuntimeException(
                        "db.properties tidak ditemukan di resources/"
                );
            }
            props.load(input);

            this.url      = props.getProperty("db.url");
            this.username = props.getProperty("db.username");
            this.password = props.getProperty("db.password");
            this.driver   = props.getProperty("db.driver");

            // Load JDBC driver class ke memori JVM
            Class.forName(this.driver);

        } catch (IOException e) {
            throw new RuntimeException("Gagal membaca db.properties: "
                    + e.getMessage(), e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("JDBC Driver tidak ditemukan: "
                    + e.getMessage(), e);
        }
    }

    // -------------------------------------------------------
    // getConnection() — dipanggil oleh setiap DAO
    // Membuat koneksi baru dari pool tiap kali dipanggil
    // -------------------------------------------------------
    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }
}
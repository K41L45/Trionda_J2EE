package com.trionda.service;

/**
 * Custom exception untuk Service layer.
 * Membungkus error bisnis (validasi gagal, data tidak ditemukan)
 * agar Servlet bisa menangkap dengan catch yang jelas.
 */
public class ServiceException extends Exception {

    public ServiceException(String message) {
        super(message);
    }

    public ServiceException(String message, Throwable cause) {
        super(message, cause);
    }
}
package com.trionda.strategy;

import java.math.BigDecimal;

/**
 * STRATEGY PATTERN — Interface
 * Mendefinisikan kontrak algoritma perhitungan harga.
 * Setiap kategori tiket punya cara hitung yang berbeda.
 */
public interface PricingStrategy {
    BigDecimal calculatePrice(BigDecimal basePrice, int quantity);
    String getCategoryName();
}
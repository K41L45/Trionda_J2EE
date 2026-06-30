package com.trionda.strategy;

import java.math.BigDecimal;

/**
 * STRATEGY: VIP ticket — harga premium, tambah 10% service fee
 */
public class VIPPricingStrategy implements PricingStrategy {

    private static final BigDecimal SERVICE_FEE = new BigDecimal("1.10");

    @Override
    public BigDecimal calculatePrice(BigDecimal basePrice, int quantity) {
        // VIP: harga dasar × quantity × 1.10 (service fee 10%)
        return basePrice
                .multiply(BigDecimal.valueOf(quantity))
                .multiply(SERVICE_FEE)
                .setScale(2, java.math.RoundingMode.HALF_UP);
    }

    @Override
    public String getCategoryName() {
        return "VIP";
    }
}
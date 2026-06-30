package com.trionda.strategy;

import java.math.BigDecimal;

/**
 * STRATEGY: Regular ticket — harga flat tanpa diskon
 */
public class RegularPricingStrategy implements PricingStrategy {

    @Override
    public BigDecimal calculatePrice(BigDecimal basePrice, int quantity) {
        return basePrice.multiply(BigDecimal.valueOf(quantity));
    }

    @Override
    public String getCategoryName() {
        return "REGULAR";
    }
}
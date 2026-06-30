package com.trionda.factory;

import com.trionda.strategy.PricingStrategy;
import com.trionda.strategy.RegularPricingStrategy;
import com.trionda.strategy.VIPPricingStrategy;

/**
 * Factory untuk membuat PricingStrategy yang tepat
 * berdasarkan nama kategori tiket.
 */
public class PricingStrategyFactory {

    public static PricingStrategy create(String categoryName) {
        return switch (categoryName.toUpperCase()) {
            case "REGULAR" -> new RegularPricingStrategy();
            case "VIP"     -> new VIPPricingStrategy();
            default -> throw new IllegalArgumentException(
                    "Unknown category: " + categoryName);
        };
    }
}
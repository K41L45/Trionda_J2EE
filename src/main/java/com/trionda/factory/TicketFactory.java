package com.trionda.factory;

import com.trionda.model.TicketCategory;

import java.math.BigDecimal;

/**
 * FACTORY METHOD PATTERN
 *
 * Tujuan: mendelegasikan pembuatan objek TicketCategory
 * ke satu titik terpusat. Caller (BookingService) tidak perlu
 * tahu cara konstruksi objek — cukup minta factory.
 *
 * Kenapa Factory Method di sini?
 * - Trionda punya 2 jenis tiket: REGULAR dan VIP
 * - Tiap jenis punya karakteristik berbeda (harga, kuota default)
 * - Kalau ada jenis baru (misal PREMIUM), cukup tambah di sini
 *   tanpa ubah kode di tempat lain
 */
public class TicketFactory {

    // Konstanta nama kategori — hindari typo string di seluruh kodebase
    public static final String REGULAR = "REGULAR";
    public static final String VIP     = "VIP";

    /**
     * Factory Method utama.
     * Menerima tipe kategori dan data spesifik,
     * mengembalikan objek TicketCategory yang sudah terkonfigurasi.
     *
     * @param categoryType  "REGULAR" atau "VIP"
     * @param matchId       match yang punya kategori ini
     * @param price         harga yang diinput admin
     * @param totalQuota    kuota yang diinput admin
     * @return TicketCategory siap pakai
     */
    public static TicketCategory create(String categoryType,
                                        long matchId,
                                        BigDecimal price,
                                        int totalQuota) {
        return switch (categoryType.toUpperCase()) {

            case REGULAR -> createRegular(matchId, price, totalQuota);
            case VIP     -> createVIP(matchId, price, totalQuota);

            default -> throw new IllegalArgumentException(
                    "Unknown ticket category: " + categoryType +
                            ". Valid values: REGULAR, VIP"
            );
        };
    }

    // REGULAR ticket — tiket standar
    private static TicketCategory createRegular(long matchId,
                                                BigDecimal price,
                                                int totalQuota) {
        TicketCategory tc = new TicketCategory();
        tc.setMatchId(matchId);
        tc.setCategoryName(REGULAR);
        tc.setPrice(price);
        tc.setTotalQuota(totalQuota);
        tc.setRemainingQuota(totalQuota); // awal: remaining = total
        return tc;
    }

    // -------------------------------------------------------
    // VIP ticket — tiket premium
    // -------------------------------------------------------
    private static TicketCategory createVIP(long matchId,
                                            BigDecimal price,
                                            int totalQuota) {
        TicketCategory tc = new TicketCategory();
        tc.setMatchId(matchId);
        tc.setCategoryName(VIP);
        tc.setPrice(price);
        tc.setTotalQuota(totalQuota);
        tc.setRemainingQuota(totalQuota); // awal: remaining = total
        return tc;
    }
}
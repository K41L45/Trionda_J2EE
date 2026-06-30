package com.trionda.model;

import java.math.BigDecimal;

public class TicketCategory {
    private long categoryId;
    private long matchId;
    private String categoryName;
    private BigDecimal price;
    private int totalQuota;
    private int remainingQuota;

    public TicketCategory() {}

    public TicketCategory(long categoryId, long matchId, String categoryName,
                          BigDecimal price, int totalQuota, int remainingQuota) {
        this.categoryId     = categoryId;
        this.matchId        = matchId;
        this.categoryName   = categoryName;
        this.price          = price;
        this.totalQuota     = totalQuota;
        this.remainingQuota = remainingQuota;
    }

    // Getters & Setters
    public long getCategoryId()                         { return categoryId; }
    public void setCategoryId(long categoryId)          { this.categoryId = categoryId; }

    public long getMatchId()                            { return matchId; }
    public void setMatchId(long matchId)                { this.matchId = matchId; }

    public String getCategoryName()                     { return categoryName; }
    public void setCategoryName(String categoryName)    { this.categoryName = categoryName; }

    public BigDecimal getPrice()                        { return price; }
    public void setPrice(BigDecimal price)              { this.price = price; }

    public int getTotalQuota()                          { return totalQuota; }
    public void setTotalQuota(int totalQuota)           { this.totalQuota = totalQuota; }

    public int getRemainingQuota()                      { return remainingQuota; }
    public void setRemainingQuota(int remainingQuota)   { this.remainingQuota = remainingQuota; }
}
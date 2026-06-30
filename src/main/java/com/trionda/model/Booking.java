package com.trionda.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Booking {
    private long bookingId;
    private String bookingCode;
    private long userId;
    private long categoryId;
    private int quantity;
    private BigDecimal totalPrice;
    private String status;
    private LocalDateTime createdAt;

    // ✅ Fields tambahan dari JOIN — untuk booking_history.jsp
    private String homeTeam;
    private String awayTeam;
    private String venue;
    private String hostCity;
    private String matchDate;
    private String categoryName;
    private String groupName;

    public Booking() {}

    public Booking(long bookingId, String bookingCode, long userId,
                   long categoryId, int quantity, BigDecimal totalPrice,
                   String status, LocalDateTime createdAt) {
        this.bookingId   = bookingId;
        this.bookingCode = bookingCode;
        this.userId      = userId;
        this.categoryId  = categoryId;
        this.quantity    = quantity;
        this.totalPrice  = totalPrice;
        this.status      = status;
        this.createdAt   = createdAt;
    }

    // ===== Getters & Setters original =====
    public long getBookingId()                        { return bookingId; }
    public void setBookingId(long bookingId)          { this.bookingId = bookingId; }
    public String getBookingCode()                    { return bookingCode; }
    public void setBookingCode(String bookingCode)    { this.bookingCode = bookingCode; }
    public long getUserId()                           { return userId; }
    public void setUserId(long userId)                { this.userId = userId; }
    public long getCategoryId()                       { return categoryId; }
    public void setCategoryId(long categoryId)        { this.categoryId = categoryId; }
    public int getQuantity()                          { return quantity; }
    public void setQuantity(int quantity)             { this.quantity = quantity; }
    public BigDecimal getTotalPrice()                 { return totalPrice; }
    public void setTotalPrice(BigDecimal totalPrice)  { this.totalPrice = totalPrice; }
    public String getStatus()                         { return status; }
    public void setStatus(String status)              { this.status = status; }
    public LocalDateTime getCreatedAt()               { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    // ===== Getters & Setters tambahan =====
    public String getHomeTeam()                       { return homeTeam; }
    public void setHomeTeam(String homeTeam)          { this.homeTeam = homeTeam; }
    public String getAwayTeam()                       { return awayTeam; }
    public void setAwayTeam(String awayTeam)          { this.awayTeam = awayTeam; }
    public String getVenue()                          { return venue; }
    public void setVenue(String venue)                { this.venue = venue; }
    public String getHostCity()                       { return hostCity; }
    public void setHostCity(String hostCity)          { this.hostCity = hostCity; }
    public String getMatchDate()                      { return matchDate; }
    public void setMatchDate(String matchDate)        { this.matchDate = matchDate; }
    public String getCategoryName()                   { return categoryName; }
    public void setCategoryName(String categoryName)  { this.categoryName = categoryName; }
    public String getGroupName()                      { return groupName; }
    public void setGroupName(String groupName)        { this.groupName = groupName; }
}
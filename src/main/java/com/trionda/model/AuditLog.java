package com.trionda.model;

import java.time.LocalDateTime;

public class AuditLog {
    private long logId;
    private long userId;
    private long bookingId;
    private String actionType;
    private String beforeState;
    private String afterState;
    private LocalDateTime changedAt;

    public AuditLog() {}

    public AuditLog(long logId, long userId, long bookingId,
                    String actionType, String beforeState,
                    String afterState, LocalDateTime changedAt) {
        this.logId       = logId;
        this.userId      = userId;
        this.bookingId   = bookingId;
        this.actionType  = actionType;
        this.beforeState = beforeState;
        this.afterState  = afterState;
        this.changedAt   = changedAt;
    }

    // Getters & Setters
    public long getLogId()                          { return logId; }
    public void setLogId(long logId)                { this.logId = logId; }

    public long getUserId()                         { return userId; }
    public void setUserId(long userId)              { this.userId = userId; }

    public long getBookingId()                      { return bookingId; }
    public void setBookingId(long bookingId)        { this.bookingId = bookingId; }

    public String getActionType()                   { return actionType; }
    public void setActionType(String actionType)    { this.actionType = actionType; }

    public String getBeforeState()                  { return beforeState; }
    public void setBeforeState(String beforeState)  { this.beforeState = beforeState; }

    public String getAfterState()                   { return afterState; }
    public void setAfterState(String afterState)    { this.afterState = afterState; }

    public LocalDateTime getChangedAt()                      { return changedAt; }
    public void setChangedAt(LocalDateTime changedAt)        { this.changedAt = changedAt; }
}
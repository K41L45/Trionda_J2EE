package com.trionda.model;

import java.time.LocalDateTime;

public class AdminActionLog {
    private long actionId;
    private long userId;
    private long matchId;
    private String actionType;
    private String beforeVal;
    private String afterVal;
    private LocalDateTime actionedAt;

    public AdminActionLog() {}

    public AdminActionLog(long actionId, long userId, long matchId,
                          String actionType, String beforeVal,
                          String afterVal, LocalDateTime actionedAt) {
        this.actionId   = actionId;
        this.userId     = userId;
        this.matchId    = matchId;
        this.actionType = actionType;
        this.beforeVal  = beforeVal;
        this.afterVal   = afterVal;
        this.actionedAt = actionedAt;
    }

    // Getters & Setters
    public long getActionId()                        { return actionId; }
    public void setActionId(long actionId)           { this.actionId = actionId; }

    public long getUserId()                          { return userId; }
    public void setUserId(long userId)               { this.userId = userId; }

    public long getMatchId()                         { return matchId; }
    public void setMatchId(long matchId)             { this.matchId = matchId; }

    public String getActionType()                    { return actionType; }
    public void setActionType(String actionType)     { this.actionType = actionType; }

    public String getBeforeVal()                     { return beforeVal; }
    public void setBeforeVal(String beforeVal)       { this.beforeVal = beforeVal; }

    public String getAfterVal()                      { return afterVal; }
    public void setAfterVal(String afterVal)         { this.afterVal = afterVal; }

    public LocalDateTime getActionedAt()                      { return actionedAt; }
    public void setActionedAt(LocalDateTime actionedAt)       { this.actionedAt = actionedAt; }
}
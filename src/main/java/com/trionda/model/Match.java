package com.trionda.model;

import java.time.LocalDateTime;

public class Match {
    private long matchId;
    private String homeTeam;
    private String awayTeam;
    private LocalDateTime matchDate;
    private String venue;
    private String hostCity;
    private String groupName;
    private String status;

    public Match() {}

    public Match(long matchId, String homeTeam, String awayTeam,
                 LocalDateTime matchDate, String venue, String hostCity,
                 String groupName, String status) {
        this.matchId   = matchId;
        this.homeTeam  = homeTeam;
        this.awayTeam  = awayTeam;
        this.matchDate = matchDate;
        this.venue     = venue;
        this.hostCity  = hostCity;
        this.groupName = groupName;
        this.status    = status;
    }

    // Getters & Setters
    public long getMatchId()                          { return matchId; }
    public void setMatchId(long matchId)              { this.matchId = matchId; }

    public String getHomeTeam()                       { return homeTeam; }
    public void setHomeTeam(String homeTeam)          { this.homeTeam = homeTeam; }

    public String getAwayTeam()                       { return awayTeam; }
    public void setAwayTeam(String awayTeam)          { this.awayTeam = awayTeam; }

    public LocalDateTime getMatchDate()                        { return matchDate; }
    public void setMatchDate(LocalDateTime matchDate)          { this.matchDate = matchDate; }

    public String getVenue()                          { return venue; }
    public void setVenue(String venue)                { this.venue = venue; }

    public String getHostCity()                       { return hostCity; }
    public void setHostCity(String hostCity)          { this.hostCity = hostCity; }

    public String getGroupName()                      { return groupName; }
    public void setGroupName(String groupName)        { this.groupName = groupName; }

    public String getStatus()                         { return status; }
    public void setStatus(String status)              { this.status = status; }
}
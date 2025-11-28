package Class;

public class Season {
    private int seasonId;
    private String seasonName;

    public Season(int seasonId, String seasonName) {
        this.seasonId = seasonId;
        this.seasonName = seasonName;
    }

    public int getSeasonId() {
        return seasonId;
    }

    public String getSeasonName() {
        return seasonName;
    }
}

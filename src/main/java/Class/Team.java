package Class;

public class Team {
	private int teamId;
    public Team() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Team(int teamId, String teamName, String homeStadium, String description, String logoPath) {
		super();
		this.teamId = teamId;
		this.teamName = teamName;
		this.homeStadium = homeStadium;
		this.description = description;
		this.logoPath = logoPath;
	}
	public int getTeamId() {
		return teamId;
	}
	public void setTeamId(int teamId) {
		this.teamId = teamId;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getHomeStadium() {
		return homeStadium;
	}
	public void setHomeStadium(String homeStadium) {
		this.homeStadium = homeStadium;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getLogoPath() {
		return logoPath;
	}
	public void setLogoPath(String logoPath) {
		this.logoPath = logoPath;
	}
	private String teamName;
    private String homeStadium;
    private String description;
    private String logoPath;
}
package Class;


import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;

import java.io.IOException;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import Class.*;
public class GoogleUtils {
	private final static String GOOGLE_CLIENT_ID = "418269843316-7v49mfvht07b4hgjq7sttdbrsehvfih3.apps.googleusercontent.com";
	private final static String GOOGLE_CLIENT_SECRET = "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";
	private final static String GOOGLE_REDIRECT_URI = "http://localhost:8081/web/LoginGoogleServlet";
	private final static String GOOGLE_GRANT_TYPE = "authorization_code";
	private final static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
	private final static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

	private GoogleUtils() {

	}

	public static String getToken(final String code) throws ClientProtocolException,IOException  {
		String response = Request.Post(GOOGLE_LINK_GET_TOKEN)
				.bodyForm(Form.form().add("client_id", GOOGLE_CLIENT_ID)
						.add("client_secret", GOOGLE_CLIENT_SECRET)
						.add("redirect_uri", GOOGLE_REDIRECT_URI)
						.add("code", code).add("grant_type", GOOGLE_GRANT_TYPE)
						.build())
				.execute().returnContent().asString();
		JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
		String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
		return accessToken;
	}
	public static GooglePoJo getUserInfo(final String accessToken) throws ClientProtocolException, 
IOException {
		String link = GOOGLE_LINK_GET_USER_INFO + accessToken;
		String response = Request.Get(link).execute().returnContent().asString();
		GooglePoJo googlePojo = new Gson().fromJson(response, GooglePoJo.class);
		System.out.println(googlePojo);
		return googlePojo;
	}
}
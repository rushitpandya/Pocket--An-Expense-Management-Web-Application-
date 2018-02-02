package pocket.utility;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.net.HttpURLConnection;

public class FacebookConnectionUtility {
	public static final String FB_APP_ID = "1495093000557891";
	public static final String FB_APP_SECRET = "fc9b8ad890c465eaa0909e5a0347bca2";
	public static final String REDIRECT_URI = "http://localhost:8080/Pocket/FacebookLoginController";

	static String accessToken = "";

	public String getFBAuthUrl() {
		String fbLoginUrl = "";
		try {
			fbLoginUrl = "https://www.facebook.com/dialog/oauth?" + "client_id="
					+ FacebookConnectionUtility.FB_APP_ID + "&redirect_uri="
					+ URLEncoder.encode(FacebookConnectionUtility.REDIRECT_URI, "UTF-8")
					+ "&scope=public_profile,email"+"&action=fblogin";
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return fbLoginUrl;
	}

	public String getFBGraphUrl(String code) {
		String fbGraphUrl = "";
		try {
			fbGraphUrl = "https://graph.facebook.com/oauth/access_token?"
					+ "client_id=" + FacebookConnectionUtility.FB_APP_ID + "&redirect_uri="
					+ URLEncoder.encode(FacebookConnectionUtility.REDIRECT_URI, "UTF-8")
					+ "&client_secret=" + FB_APP_SECRET + "&code=" + code +"&action=fblogin";
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return fbGraphUrl;
	}

	public String getAccessToken(String code) {
		if ("".equals(accessToken)) {
			URL fbGraphURL;
			try {
				fbGraphURL = new URL(getFBGraphUrl(code));
			} catch (MalformedURLException e) {
				e.printStackTrace();
				throw new RuntimeException("Invalid code received " + e);
			}
			HttpURLConnection fbConnection;
			StringBuffer b = null;
			try {
				fbConnection = (HttpURLConnection)fbGraphURL.openConnection();
				fbConnection.setRequestMethod("GET");
				BufferedReader in;
				in = new BufferedReader(new InputStreamReader(
						fbConnection.getInputStream()));
				String inputLine;
				String outString="";
				//b = new StringBuffer();
				while ((inputLine = in.readLine()) != null)
				{
					outString +=inputLine;
				}	
				System.out.println(outString);
		
                   accessToken = outString.substring(17,outString.indexOf(",")-1);
					System.out.println(accessToken);	
					//accessToken = outString;
					in.close();
			} catch (IOException e) {
				e.printStackTrace();
				throw new RuntimeException("Unable to connect with Facebook "
						+ e);
			}
		}
		return accessToken;
	}
}
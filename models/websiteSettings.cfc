/**
*
* @file  /C/inetpub/wwwroot/finealley/FineAlleyWebsite2/models/websiteSettings.cfc
* @author  Christopher Vachon
* @description  holds all the settings for the website
*
*/

component output="false" displayname="websiteSettings" extends="base" persistent="true" table="websiteSettings" {

	property name="domain" type="string" setter="false";
	property name="siteName" type="string";
	property name="description" type="string";

	// Facebook Connection
	property name="FB_appID" type="string";
	property name="FB_appSecret" type="string";
	property name="FB_pageID" type="string";

	// OPENGRAPH
	property name="openGraphTags" fieldtype="collection" type="struct" table="websiteSettings_ogTags" fkcolumn="fk_WebsiteSettingsID" structkeycolumn="OGKey" structkeytype="string" elementColumn="OGValue" elementtype="string" lazy="false";

	// Google
	property name="Google_gaCode" type="string";


	public function init(){
		this.refreshProperties();
		return super.init();
	}

	public void function refreshProperties() {
		super.refreshProperties();
		if (!structKeyExists(VARIABLES,"domain")) { VARIABLES["domain"] = CGI.SERVER_NAME; }
		if (!structKeyExists(VARIABLES,"siteName")) { VARIABLES["siteName"] = "New Band Site"; }
		if (!structKeyExists(VARIABLES,"description")) { VARIABLES["description"] = "This is a New Band Site"; }

		// Facebook
		if (!structKeyExists(VARIABLES,"FB_appID")) { VARIABLES["FB_appID"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"FB_appSecret")) { VARIABLES["FB_appSecret"] = javaCast("null",""); }
		if (!structKeyExists(VARIABLES,"FB_pageID")) { VARIABLES["FB_pageID"] = javaCast("null",""); }

		// openGraph
		if (!structKeyExists(VARIABLES,"openGraphTags")) { VARIABLES["openGraphTags"] = {}; }

		// Google
		if (!structKeyExists(VARIABLES,"Google_gaCode")) { VARIABLES["Google_gaCode"] = javaCast("null",""); }
	}


	public boolean function hasAllFacebookInfo() {
		if (!isNull(this.getFB_appID()) && (len(this.getFB_appID()) > 0)) {
			if (!isNull(this.getFB_appSecret()) && (len(this.getFB_appSecret()) > 0)) {
				if (!isNull(this.getFB_pageID()) && (len(this.getFB_pageID()) > 0)) {
					return true;
				}
			}
		}
		return false;
	}
}
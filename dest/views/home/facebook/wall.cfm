<cfscript>
	param name="RC.fbWallData" default=arrayNew(1);
	param name="REQUEST.CACHE" default=structNew();
	param name="REQUEST.CACHE.facebook" default=structNew();


	LOCAL._appID = APPLICATION.websiteSettings.getFB_appID();
	LOCAL._appSecrect = APPLICATION.websiteSettings.getFB_appSecret();
	LOCAL._pageID = APPLICATION.websiteSettings.getFB_pageID();
	LOCAL._accessToken = "#LOCAL._appID#|#LOCAL._appSecrect#";
	RC.facebookGraphAPI = new services.FacebookGraphAPI().init(LOCAL._accessToken,LOCAL._appID);

	RC.userCache = {};

	function getUserData(id) {
		if (!structKeyExists(RC.userCache,ARGUMENTS.id)) {
			RC.userCache[ARGUMENTS.id] = RC.facebookGraphAPI.getObject(
				id=ARGUMENTS.id,
				fields="name,link,picture"
			);
		}
		return RC.userCache[ARGUMENTS.id];
	}
</cfscript>
<cfoutput>
	<div class='fb-wall'>
		<cfloop array="#RC.fbWallData#" index="LOCAL.feedData">
			<cfscript>
				LOCAL.userData = getUserData(LOCAL.feedData.from.id);
				//writeDump(LOCAL.userData);
			</cfscript>
			<article class='wall-item media'>
				<a href='#replace(LOCAL.userData.link,"&","&amp;","all")#' class='pull-left' target='_blank' title='goto #LOCAL.userData.name# profile on facebook'><img src='#LOCAL.userData.picture.data.url#' class='media-object' alt='image of #LOCAL.userData.name#' /></a>
				<div class='media-body'>
					<header class='media-heading'>
						<span class='pull-right post-date'>#dateFormat(fbUtilities.createDateTimeFromFBTimeStamp(LOCAL.feedData.created_time),"MMM D")#</span>
						<a href='#replace(LOCAL.userData.link,"&","&amp;","all")#' target='_blank' title='goto #LOCAL.userData.name# profile on facebook'>#LOCAL.userData.name#</a>
					</header>
					<div class='body'>
						<cfif structKeyExists(LOCAL.feedData, "story")>
							<p>#LOCAL.feedData.story#</p>
						</cfif>
						<cfif structKeyExists(LOCAL.feedData, "full_picture")>
							<a href='#replace(LOCAL.feedData.link,"&","&amp;","all")#' target='_blank' title='expand image'>
								<img src='#replace(LOCAL.feedData.full_picture,"&","&amp;","all")#' class='img-responsive img-thumbnail' alt='post image' />
							</a>
						</cfif>
						<cfif structKeyExists(LOCAL.feedData, "message")>
							<p>#LOCAL.feedData.message#</p>
						</cfif>
					</div>
					<footer>
						<cfscript>
							if (structKeyExists(LOCAL.feedData, "likes")) {
								LOCAL.likes = arrayLen(LOCAL.feedData.likes.data);
							} else {
								LOCAL.likes = 0;
							}
						</cfscript>
						<span class='label label-primary'>#LOCAL.likes# Like<cfif LOCAL.likes NEQ 1>s</cfif></span>
					</footer>
					<cfif structKeyExists(LOCAL.feedData, "comments")>
						<section class='comments'>
							<header class='row'>
								<p>Comments</p>
							</header>
							<cfloop array="#LOCAL.feedData.comments.data#" index="LOCAL.comment">
								<div class='media'>
									<cfscript>
										//writeDump(LOCAL.comment); abort;
										LOCAL.userData = getUserData(LOCAL.comment.from.id);
										//writeDump(LOCAL.userData);
									</cfscript>
									<cfif structKeyExists(LOCAL.userData,"link")>
									<a href='#replace(LOCAL.userData.link,"&","&amp;","all")#' class='pull-left' target='_blank' title='goto #LOCAL.userData.name# profile on facebook'><img src='#replace(LOCAL.userData.picture.data.url,"&","&amp;","all")#' class='media-object' alt='image of #LOCAL.userData.name#' /></a>
									<cfelse>
										<div class='pull-left'><img src='#replace(LOCAL.userData.picture.data.url,"&","&amp;","all")#' class='media-object' alt='image of #LOCAL.userData.name#' /></div>
									</cfif>
									<div class='media-body'>
										<header class='media-heading'>
											<cfif structKeyExists(LOCAL.userData,"link")>
												<a href='#replace(LOCAL.userData.link,"&","&amp;","all")#' target='_blank' title='goto #LOCAL.userData.name# profile on facebook'>#LOCAL.userData.name#</a>
											<cfelse>
												#LOCAL.userData.name#
											</cfif>
										</header>
                                 
										<p>#dateFormat(fbUtilities.createDateTimeFromFBTimeStamp(LOCAL.comment.created_time),"MMM D")#</p>
										<p>#LOCAL.comment.message#</p>
										<footer>
										</footer>
									</div>
								</div>
							</cfloop>
						</section>
					</cfif>
				</div>
			</article>
		</cfloop>
	</div>
</cfoutput>
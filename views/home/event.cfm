<cfoutput>
	<article class='col-lg-6 col-md-12'>
		<header><h3><a href='/event/#year(RC.event.getDateTime())#/#month(RC.event.getDateTime())#/#day(RC.event.getDateTime())#/#RC.event.getEncodedTitle()#'>#RC.event.getTitle()#</a></h3></header>
		#RC.event.getBody()#
		<footer>
			<p>Date: #dateFormat(RC.event.getDateTime(),"MMM D, YYYY")# @ #timeFormat(RC.event.getDateTime(),"H:MM")#</p>
			<p>Location: #RC.event.getLocation()#</p>
		</footer>
		<cfif REQUEST.security.checkPermission("isAdmin")>
			<div class='btn-group btn-mini'>
				<a href='/admin/editEvent/eventID/#RC.event.getID()#' class='btn btn-default btn-xs'>Edit Event</a>
			</div>
		</cfif>
	</article>
</cfoutput>
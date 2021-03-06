<cfscript>
	LOCAL.eventTimespan = [
		{label="Upcoming Events",array=RC.upcoming_events},
		{label="Past Events",array=RC.past_events}
	];
</cfscript>
<cfoutput>
	<cfloop array="#LOCAL.eventTimespan#" index="LOCAL.data">
		<h2>#LOCAL.data.label#</h2>
		<table class='table'>
			<thead>
				<tr>
					<th class='col-xs-5'>Event</th>
					<th class='col-xs-3'>Date</th>
					<th class='col-xs-4'>Location</th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan='3'></td>
				</tr>
			</tfoot>
			<tbody>
				<cfloop array="#LOCAL.data.array#" index="LOCAL.event">
					<tr>
						<td><a href='/event#LOCAL.event.getURI()#'>#LOCAL.event.getTitle()#</a></td>
						<td>#dateFormat(LOCAL.event.getDateTime(),"MMMM D, YYYY")#</td>
						<td>
							<cfif LOCAL.event.hasVenue()>
								<a href='/venue/#LOCAL.event.getVenue().getEncodedName()#'>#LOCAL.event.getVenue().getName()#</a>
							<cfelseif len(LOCAL.event.getLocation()) GT 0>
								#LOCAL.event.getLocation()#
							</cfif>
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	</cfloop>
</cfoutput>
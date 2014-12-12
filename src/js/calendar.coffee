app = angular.module 'communitycal', [
					'LocalStorageModule',
					'ui.bootstrap',
					'communitycal.services']

app.directive "communityCalendar", (steam) ->
	restrict: "E"
	template: """
						<div class="community-calendar tabbable tabs-below">
							<div class="tab-content">
							<div ng-show="active == 'list'" class="tab-pane active">
								<ul>
									<li class="cc-event" ng-repeat="event in events">
										<a href="#/communitycal/{{event.id}}">
											<div class="cc-event-date">
												<div class="cc-event-day">{{ day(event.date) }}</div>
												<div class="cc-event-month">{{ month(event.date) }}</div>
												<div class="cc-event-year">{{ year(event.date) }}</div>
												<div class="cc-event-time">{{ time(event.date) }}</div>
											</div>
											<div class="cc-event-title">{{ event.title }}</div>
											<div class="cc-event-location">{{ event.address }}</div>
										</a>
									</li>
								</ul>
							</div>
							<div ng-show="active == 'cal'" class="tab-pane active">calendar view</div>
							<div ng-show="active == 'add'" class="tab-pane active"><font color="blue" face="arial bold" size="3"><center><u><b>ADD EVENTS HERE</b></u></center></font>
							<font color="black" face="arial" size="2">
			<br><u>Title</u> <input type="text" name="title" required="required">
			<br>
			
			<hr>
			<u>Location</u>
			
			<br><br>
			City <input type="text" name="City" required="required">
			
			<br>
			<br>
			Country <input type="text" name="Country" required="required">	
			
			<br>
			<hr>
			<u>Date & Time</u>
			<br>
			
			
			<br>
			Date <input type="text" name="date" required="required">
			<br><br>
			
				
			Time <input type="text" name="time" required="required">
			<br>
			<br>
			
			<hr>
			<br>
			<u>URL</u> <input type="text" name="URL" required="required">	
			<br>
			<br>
			<button class="btn" ><b>Add Event</b></button>
	</font></div>
							</div>
							<ul class="nav nav-tabs">
								<li><a data-toggle="tab" ng-click="active = 'list'">list</a></li>
								<li><a data-toggle="tab" ng-click="active = 'cal'">cal</a></li>
								<li><a data-toggle="tab" ng-click="active = 'add'">add</a></li>
							</ul>
						</div>
						"""
	link: (scope, element, attrs) ->
		scope.active = "list"
		console.log("(cal-widget:link)")
		steam.get("techgrind.events/order-by-date").then (data) ->
			scope.events = data['event-list']
			console.log(JSON.stringify(scope.events))

		scope.date = (unix) ->
			date = new Date(unix*1000)
			date.toDateString()

		scope.day = (unix) ->
			date = new Date(unix*1000)
			date.getDate()

		scope.month = (unix) ->
			date = new Date(unix*1000)
			["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][date.getMonth()]

		scope.year = (unix) ->
			date = new Date(unix*1000)
			date.getFullYear()

		scope.time = (unix) ->
			date = new Date(unix*1000)
			date.getTime()

		scope.tabs = [
			{ title:'Dynamic Title 1', content:'Dynamic content 1' },
			{ title:'Dynamic Title 2', content:'Dynamic content 2', disabled: true }
			]

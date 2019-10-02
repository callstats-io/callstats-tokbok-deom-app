// Initialize an OpenTok Session object
var session = OT.initSession(apiKey, sessionId);

// Initialize a Publisher, and place it into the element with id="publisher"
var publisher = OT.initPublisher('publisher');

const InitCallback = (t) => {
  console.warn('callstats initialized ', t);
}
const StatsCallback = (t) => {
  console.warn('callstats stats callback ', t);
}
const payload = {
  AppId: 'callstats_app_id',
  AppSecret: 'callstats_app_secret',
  SessionId: sessionId,
  InitCallback: InitCallback,
  StatsCallback: StatsCallback,
}
var connection = CallstatsOpenTok.initialize(payload);

console.warn('callstats is ', connection, payload);
// Attach event handlers
session.on({

  // This function runs when session.connect() asynchronously completes
  sessionConnected: function(event) {
    // Publish the publisher we initialzed earlier (this will trigger 'streamCreated' on other
    // clients)
    session.publish(publisher, err => {
      if (error) {
        console.error('Failed to publish', error);
      }
    });
  },

  // This function runs when another client publishes a stream (eg. session.publish())
  streamCreated: function(event) {
    // Create a container for a new Subscriber, assign it an id using the streamId, put it inside
    // the element with id="subscribers"
    var subContainer = document.createElement('div');
    subContainer.id = 'stream-' + event.stream.streamId;
    document.getElementById('subscribers').appendChild(subContainer);

    // Subscribe to the stream that caused this event, put it inside the container we just made
    session.subscribe(event.stream, subContainer, (error) => {
      if (error) {
        console.error('Failed to subscribe', error);
      }
    });

  }

});

// Connect to the Session using a 'token' for permission
session.connect(token, (error) => {
  if (error) {
    console.error('Failed to connect', error);
  }
});

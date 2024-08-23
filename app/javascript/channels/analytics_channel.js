import consumer from "channels/consumer";

consumer.subscriptions.create("AnalyticsChannel", {
	connected() {
		console.log("Connected to AnalyticsChannel");
	},

	disconnected() {
		console.log("Disconnected from AnalyticsChannel");
	},

	received() {},
});

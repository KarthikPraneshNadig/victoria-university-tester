App.conversation = App.cable.subscriptions.create("ConversationChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    console.log(data['message']);
  },
  speak: function(message) {
    return this.perform('speak', {
      message: message
    });
  }
});
$(document).on('submit', '.new_message', function(e) {
  e.preventDefault();
  let values = $(this).serializeArray();
  App.conversation.speak(values);
  $(this).trigger('reset');
});

#speak runs the speak method on the back end which will send a object that includes a passed parameter (for example the message)
# the received method will log the result on the back end 
#  we also added code which is performed with form submission 
# It serializes form’s values, runs the speak method, and resets its values.
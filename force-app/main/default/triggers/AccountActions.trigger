trigger AccountActions on Account (after insert) {
   AccountActionHandler.createContact(trigger.new);
}
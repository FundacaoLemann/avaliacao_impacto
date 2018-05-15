class UpdateCardMemberWorker
  include Sidekiq::Worker

  def perform(collect_entry_id)
    collect_entry = CollectEntry.find(collect_entry_id)
    assignee = collect_entry.member.pipefy_id
    PipefyApi.post(
      Pipefy::Card.update_assignee(
        collect_entry.card_id.to_i,
        assignee
      )
    )
  end
end

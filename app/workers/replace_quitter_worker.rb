class ReplaceQuitterWorker
  include Sidekiq::Worker

  def perform(collect_entry_id)
    collect_entry = CollectEntry.find(collect_entry_id)
    collect = collect_entry.collect
    substitute = CollectEntry.where(
      collect: collect,
      administration: collect_entry.administration,
      group: "Repescagem"
    ).first
    substitute.update(substitute: true)
    pipe = collect.pipe
    PipefyApi.post(pipe.move_card_to_phase(substitute.card_id, :triagem))
  end
end

class ReplaceQuitterWorker
  include Sidekiq::Worker

  def perform(collect_entry_id)
    collect_entry = CollectEntry.find(collect_entry_id)
    collect = collect_entry.collect
    substitute = CollectEntry.where(
      collect: collect,
      administration: collect_entry.administration,
      name: collect_entry.name,
      group: "Repescagem",
      substitute: false
    ).order(:school_sequence).first
    return unless substitute
    substitute.update(substitute: true)
    pipe = collect.pipe
    PipefyApi.post(pipe.move_card_to_phase(substitute.card_id, :triagem))
  end
end

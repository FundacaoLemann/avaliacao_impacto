class Contact < ApplicationRecord
  belongs_to :collect
  belongs_to :school, foreign_key: "school_inep", primary_key: "inep", optional: true
  validate :valid_collect_entry_exists, if: proc { |contact| contact.send_to_pipefy }

  private

  def valid_collect_entry_exists
    collect_entry = CollectEntry.where(collect_id: self.collect_id, school_inep: self.school_inep).last
    if collect_entry.blank? or collect_entry.card_id.blank?
      errors.add :collect_id,
        I18n.t('activerecord.errors.messages.invalid_contacts_csv',
          default: 'with id %{collect_id} and school_inep %{inep} does not have a collect entry with valid card_id', collect_id: self.collect_id.inspect, inep: self.school_inep.inspect)
    end
  end
end

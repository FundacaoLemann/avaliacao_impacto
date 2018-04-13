class PipefyController < ApplicationController
  def clone_pipe
    collect = Collect.find(params[:collect_id])
    response = PipefyApi.post(Pipefy::Pipe.clone_query)

    parsed_response = JSON.parse(response.body)
    cloned_pipe_id = parsed_response["data"]["clonePipes"]["pipes"][0]["id"]

    cloned_pipe = JSON.parse(PipefyApi.post(Pipefy::Pipe.show(cloned_pipe_id)))

    # CREATE PIPE WITH RESPONSE
    pipe = Pipefy::Pipe.create_from_json_response(cloned_pipe)

    collect.update(pipe: pipe)

    PipefyApi.post(pipe.update_pipe_name(collect.name))

    collect.collect_entries.find_each do |collect_entry|
      puts "Creating card"
      school_name = collect_entry.school.to_s
      adm_name = collect_entry.administration.name
      adm_contact = collect_entry.administration.contact_name
      ce_group = collect_entry.group

      response = PipefyApi.post(
        Pipefy::Card.create_card(
          cloned_pipe_id,
          school_name,
          adm_name,
          adm_contact,
          ce_group
        )
      )

      parsed_response = JSON.parse(response.body)
      card_id = parsed_response["data"]["createCard"]["card"]["id"]

      collect_entry.update(card_id: card_id.to_i)
    end

    redirect_to admin_collects_path, notice: "Processo de criação de cards no pipefy concluído"
  end

  private
  def pipe_params
    params.permit(:collect_id)
  end
end

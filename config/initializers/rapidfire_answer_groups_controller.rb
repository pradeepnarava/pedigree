Rapidfire::AnswerGroupsController.class_eval do
	def create
      @answer_group_builder = Rapidfire::AnswerGroupBuilder.new(answer_group_params)

      if @answer_group_builder.save
        redirect_to "/user_relations"
      else
        render :new
      end
    end
end
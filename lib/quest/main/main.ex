defmodule Quest.Main do
  @moduledoc """
  The boundary for the Main system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Quest.Repo

  alias Quest.Main.Questionnaire
  alias Quest.Main.Question

  @doc """
  Returns the list of questionnaires.

  ## Examples

      iex> list_questionnaires()
      [%Questionnaire{}, ...]

  """
  def list_questionnaires do
    Repo.all(Questionnaire)
  end

  @doc """
  Gets a single questionnaire.

  Raises `Ecto.NoResultsError` if the Questionnaire does not exist.

  ## Examples

      iex> get_questionnaire!(123)
      %Questionnaire{}

      iex> get_questionnaire!(456)
      ** (Ecto.NoResultsError)

  """
  def get_questionnaire!(id) do
    questionnaire = Repo.get!(Questionnaire, id)
    # questionnaire = Repo.preload questionnaire, :main_questions
    questionnaire = Repo.preload questionnaire, main_questions: from(q in Quest.Main.Question, where: q.active == ^true, order_by: [asc: q.order]) 
  end
  
  @doc """
  Creates a questionnaire.

  ## Examples

      iex> create_questionnaire(%{field: value})
      {:ok, %Questionnaire{}}

      iex> create_questionnaire(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_questionnaire(attrs \\ %{}) do
    %Questionnaire{}
    |> questionnaire_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a questionnaire.

  ## Examples

      iex> update_questionnaire(questionnaire, %{field: new_value})
      {:ok, %Questionnaire{}}

      iex> update_questionnaire(questionnaire, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_questionnaire(%Questionnaire{} = questionnaire, attrs) do
    questionnaire
    |> questionnaire_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Questionnaire.

  ## Examples

      iex> delete_questionnaire(questionnaire)
      {:ok, %Questionnaire{}}

      iex> delete_questionnaire(questionnaire)
      {:error, %Ecto.Changeset{}}

  """
  def delete_questionnaire(%Questionnaire{} = questionnaire) do
    Repo.delete(questionnaire)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking questionnaire changes.

  ## Examples

      iex> change_questionnaire(questionnaire)
      %Ecto.Changeset{source: %Questionnaire{}}

  """
  def change_questionnaire(%Questionnaire{} = questionnaire) do
    questionnaire_changeset(questionnaire, %{})
  end

  defp questionnaire_changeset(%Questionnaire{} = questionnaire, attrs) do
    questionnaire
    |> cast(attrs, [:title, :info, :status, :tags])
    # |> cast_assoc(:main_questions, required: false)
    # |> cast_assoc(:main_submissions, required: false)
    |> validate_required([:title, :info, :status, :tags])
    |> validate_length(:info, max: 4000, message: "Should be less than 4000 characters long")
    |> validate_length(:title, max: 100, min: 3, message: "Should be between 3 and 100 characters long")
  end

  alias Quest.Main.Question

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions do
    Repo.all(Question)
  end

  def list_questions_of(id) do
    Repo.all(from q in Question, where: q.questionnaire_id == ^id, order_by: [asc: q.order])
  end


  def get_latest_question(qid) do
    Repo.one(from q in Question, where: q.questionnaire_id == ^qid, order_by: [desc: q.order], limit: 1)
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question!(id), do: Repo.get!(Question, id)

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question(attrs \\ %{}) do
    %Question{}
    |> question_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question(%Question{} = question, attrs) do
    question
    |> question_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Ecto.Changeset{source: %Question{}}

  """
  def change_question(%Question{} = question) do
    question_changeset(question, %{})
  end

  defp question_changeset(%Question{} = question, attrs) do
    question
    |> cast(attrs, [:title, :info, :content, :order, :type, :required, :active, :inline, :questionnaire_id])
    # |> cast_assoc(:main_options, required: false)
    |> validate_required([:title, :content, :order, :type, :required, :inline, :questionnaire_id])
    |> validate_length(:info, max: 4000, message: "Should be less than 4000 characters long")
  end

  alias Quest.Main.Option

  @doc """
  Returns the list of options.

  ## Examples

      iex> list_options()
      [%Option{}, ...]

  """
  def list_options do
    Repo.all(Option)
  end

  @doc """
  Gets a single option.

  Raises `Ecto.NoResultsError` if the Option does not exist.

  ## Examples

      iex> get_option!(123)
      %Option{}

      iex> get_option!(456)
      ** (Ecto.NoResultsError)

  """
  def get_option!(id), do: Repo.get!(Option, id)

  @doc """
  Creates a option.

  ## Examples

      iex> create_option(%{field: value})
      {:ok, %Option{}}

      iex> create_option(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_option(attrs \\ %{}) do
    %Option{}
    |> option_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a option.

  ## Examples

      iex> update_option(option, %{field: new_value})
      {:ok, %Option{}}

      iex> update_option(option, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_option(%Option{} = option, attrs) do
    option
    |> option_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Option.

  ## Examples

      iex> delete_option(option)
      {:ok, %Option{}}

      iex> delete_option(option)
      {:error, %Ecto.Changeset{}}

  """
  def delete_option(%Option{} = option) do
    Repo.delete(option)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking option changes.

  ## Examples

      iex> change_option(option)
      %Ecto.Changeset{source: %Option{}}

  """
  def change_option(%Option{} = option) do
    option_changeset(option, %{})
  end

  defp option_changeset(%Option{} = option, attrs) do
    option
    |> cast(attrs, [:title, :order, :question_id])
    # |> cast_assoc(:main_options, required: false)
    |> validate_required([:title, :order, :question_id])
    # |> unique_constraint(:order)
  end

  alias Quest.Main.Submission

  @doc """
  Returns the list of submissions.

  ## Examples

      iex> list_submissions()
      [%Submission{}, ...]

  """
  def list_submissions do
    Repo.all(Submission)
  end

  @doc """
  Gets a single submission.

  Raises `Ecto.NoResultsError` if the Submission does not exist.

  ## Examples

      iex> get_submission!(123)
      %Submission{}

      iex> get_submission!(456)
      ** (Ecto.NoResultsError)

  """
  def get_submission!(id), do: Repo.get!(Submission, id)
  def get_submission_by(uid), do: Repo.get_by(Submission, uid: uid)

  @doc """
  Creates a submission.

  ## Examples

      iex> create_submission(%{field: value})
      {:ok, %Submission{}}

      iex> create_submission(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_submission(attrs \\ %{}) do
    %Submission{}
    |> submission_changeset(attrs)
    |> Repo.insert()
  end
    # changeset = Submission.changeset(%Prijava{}, %{ "answers" => answers, "questionnaire_id" => questionnaire_id,  "meta" => meta, "active" => false})

  @doc """
  Updates a submission.

  ## Examples

      iex> update_submission(submission, %{field: new_value})
      {:ok, %Submission{}}

      iex> update_submission(submission, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_submission(%Submission{} = submission, attrs) do
    submission
    |> submission_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Submission.

  ## Examples

      iex> delete_submission(submission)
      {:ok, %Submission{}}

      iex> delete_submission(submission)
      {:error, %Ecto.Changeset{}}

  """
  def delete_submission(%Submission{} = submission) do
    Repo.delete(submission)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking submission changes.

  ## Examples

      iex> change_submission(submission)
      %Ecto.Changeset{source: %Submission{}}

  """
  def change_submission(%Submission{} = submission) do
    submission_changeset(submission, %{})
  end

  defp submission_changeset(%Submission{} = submission, attrs) do
    submission
    |> cast(attrs, [:answers, :meta, :active, :uid, :questionnaire_id])
    |> validate_required([:answers, :meta])
  end
end

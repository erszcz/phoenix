defmodule Phoenix.JSON do
  @moduledoc """
  Phoenix.JSON is the compatibility layer which hides the differences between
  various JSON libraries.
  """

  @json_library Application.compile_env(:phoenix, :json_library, Poison)

  @doc """
  Returns the configured JSON encoding library for Phoenix.

  If you want to encode to JSON please use `encode!/1`.

  To customize the JSON library, include the following
  in your `config/config.exs`:

      config :phoenix, :json_library, AlternativeJsonLibrary

  """
  def json_library, do: @json_library

  case @json_library do
    Poison ->
      def encode!(data) do
        Poison.encode!(data, iodata: true)
      end

    Jason ->
      def encode!(data) do
        Jason.encode_to_iodata!(data)
      end
  end

end

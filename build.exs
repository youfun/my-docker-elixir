defmodule Build do
  @moduledoc false

  defmodule Version do
    @moduledoc false

    @enforce_keys [:major, :minor, :patch]
    defstruct [:major, :minor, :patch]

    @type t :: %__MODULE__{
            major: non_neg_integer(),
            minor: non_neg_integer(),
            patch: String.t()
          }

    def from(text) do
      case String.split(text, ".") do
        [major, minor | patch] ->
          patch = Enum.join(patch, ".")

          %__MODULE__{
            major: String.to_integer(major),
            minor: String.to_integer(minor),
            patch: patch
          }

        _ ->
          raise "Invalid version: #{text}"
      end
    end

    def format_major_minor(version) do
      "#{version.major}.#{version.minor}"
    end
  end

  def run([version_text, base]) do
    version = Version.from(version_text)
    major_dot_minor = Version.format_major_minor(version)

    build_dockerfile(major_dot_minor, base)

    {:ok, full_version_re} = Regex.compile("Elixir\s#{version_text}")

    if get_version_output(major_dot_minor, base) =~ full_version_re do
      IO.puts("#{IO.ANSI.green()}ok#{IO.ANSI.reset()}")
    else
      IO.puts("test #{IO.ANSI.red()}failed#{IO.ANSI.reset()}")
    end
  end

  defp build_dockerfile(version, base) do
    System.cmd("docker", ["build", "-t", "local/elixir:#{version}-#{base}", "#{version}/#{base}"],
      into: IO.stream(:stdio, :line)
    )
  end

  defp get_version_output(version, base) do
    {output, 0} =
      System.cmd("docker", [
        "run",
        "--rm",
        "--entrypoint",
        "elixir",
        "local/elixir:#{version}-#{base}",
        "--version"
      ])

    output
  end
end

Build.run(System.argv())

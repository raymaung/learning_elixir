defmodule Ch8.Subscriber do
  defstruct name: "", paid: false, over_18: true
end

defmodule Ch8.Attendee do

  defstruct name: "", paid: false, over_18: true

  def may_attend_after_party(attendee = %Ch8.Attendee{}) do
    attendee.paid && attendee.over_18
  end

  def print_vip_badge(%Ch8.Attendee{ name: name}) when name != "" do
    IO.puts "Very chap badge for #{ name }"
  end

  def print_vip_badge(%Ch8.Attendee{}) do
    raise "Missing name for badge"
  end
end

defmodule Ch8.Customer do
  defstruct name: "", company: ""
end

defmodule Ch8.BugReport do
  defstruct owner: %{}, details: "", severity: 1
end
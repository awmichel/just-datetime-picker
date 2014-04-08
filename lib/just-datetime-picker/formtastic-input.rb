module Formtastic
  module Inputs
    class JustDatetimePickerInput
      include ::Formtastic::Inputs::Base

      AMPM_TIME_OPTIONS = [["12 AM", 0],["01 AM", 1],["02 AM", 2],["03 AM", 3],
        ["04 AM", 4],["05 AM", 5],["06 AM", 6],["07 AM", 7],
        ["08 AM", 8],["09 AM", 9],["10 AM", 10],["11 AM", 11],
        ["12 PM", 12],["01 PM", 13],["02 PM", 14],["03 PM", 15],
        ["04 PM", 16],["05 PM", 17],["06 PM", 18],["07 PM", 19],
        ["08 PM", 20],["09 PM", 21],["10 PM", 22],["11 PM", 23]].freeze

      def to_html
        input_wrapping do
          combined_value = builder.object.send(method)

          hour_value_raw = builder.object.send("#{method}_time_hour")
          if not hour_value_raw.nil?
            hour_value = hour_value_raw
          elsif not combined_value.nil?
            hour_value = combined_value.hour
          else
            hour_value = "00"
          end

          minute_value_raw = builder.object.send("#{method}_time_minute")
          if not minute_value_raw.nil?
            minute_value = minute_value_raw
          elsif not combined_value.nil?
            minute_value = combined_value.min
          else
            minute_value = "00"
          end

          hour_value   = sprintf("%02d", hour_value)
          minute_value = sprintf("%02d", minute_value)

          label_html <<
          builder.text_field("#{method}_date", input_html_options.merge({ :class => "just-datetime-picker-field just-datetime-picker-date datepicker", :value => builder.object.send("#{method}_date"), :maxlength => 10, :size => 10 })) <<

          builder.select("#{method}_time_hour", AMPM_TIME_OPTIONS, input_html_options.merge({ :class => "just-datetime-picker-field just-datetime-picker-time just-datetime-picker-time-hour", :value => hour_value })) <<
          ":" <<
          builder.text_field("#{method}_time_minute", input_html_options.merge({ :class => "just-datetime-picker-field just-datetime-picker-time just-datetime-picker-time-minute", :value => minute_value, :maxlength => 2, :size => 2 }))
        end
      end
    end
  end
end



# frozen-string-literal: true

require 'csv'

# EnumCSV exposes a single method, csv, for easily creating CSV
# output/files from enumerable objects.
module EnumCSV
  # Create CSV from the given Enumerable object. If a block is given,
  # each item in the enumerable is yielded to the block, and the block
  # should return an array of of items to use for the CSV line.
  #
  # Options:
  # :headers :: Should be an array of headers to use as the first
  #             line of the CSV output, or a comma-delimited string
  #             of headers.
  # :file :: Output to the given file and return nil instead of
  #          returning a string with the CSV output.
  # all other options :: Passed to CSV.open or CSV.generate
  def csv(enum, opts={})
    headers = opts[:headers]
    headers = headers.split(',') if headers.is_a?(String)
    has_headers = headers.is_a?(Array) && !opts.has_key?(:write_headers)
    has_file = opts[:file]

    if has_headers || has_file
      opts = opts.dup
      file = opts.delete(:file)

      if has_headers
        opts[:write_headers] = true
        opts[:headers] = headers
      end
    end

    csv_proc = proc do |csv|
      enum.each do |line|
        line = yield(line) if block_given?
        csv << line
      end
    end

    if file
      CSV.open(file, 'wb', **opts, &csv_proc)
      nil
    else
      CSV.generate(**opts, &csv_proc)
    end
  end
  module_function :csv
end

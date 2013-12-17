# EnumCSV exposes a single method, csv, for easily creating CSV
# output/files from enumerable objects.
module EnumCSV
  if RUBY_VERSION >= '1.9'
    require 'csv'
  else
    require 'fastercsv'
    # Use FasterCSV on ruby 1.8
    CSV = ::FasterCSV
  end

  # Create CSV from the given Enumerable object. If a block is given,
  # each item in the enumerable is yielded to the block, and the block
  # should return an array of of items to use for the CSV line.
  #
  # Options:
  # :headers :: Should be an array of headers to use as the first
  #             line of the CSV output.
  # :file :: Output to the given file and return nil instead of
  #          returning a string with the CSV output.
  # all other options :: Passed to CSV.open or CSV.generate
  def csv(enum, opts={})
    if opts[:headers].is_a?(Array) && !opts.has_key?(:write_headers)
      opts = opts.merge(:write_headers=>true)
    end

    csv_proc = proc do |csv|
      enum.each do |line|
        line = yield(line) if block_given?
        csv << line
      end
    end

    if opts[:file]
      opts = opts.dup
      file = opts.delete(:file)
      CSV.open(file, 'wb', opts, &csv_proc)
      nil
    else
      CSV.generate(opts, &csv_proc)
    end
  end
  module_function :csv
end

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

  if RUBY_VERSION >= "2.0"
    instance_eval(<<-END, __FILE__, __LINE__+1)
      def self.csv_call(*args, opts, &block)
        CSV.send(*args, **opts, &block)
      end
    END
  else
    def self.csv_call(*args, &block)
      CSV.send(*args, &block)
    end
  end

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
    if headers.is_a?(Array) && !opts.has_key?(:write_headers)
      opts = opts.merge(:write_headers=>true, :headers=>headers)
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
      EnumCSV.csv_call(:open, file, 'wb', opts, &csv_proc)
      nil
    else
      EnumCSV.csv_call(:generate, opts, &csv_proc)
    end
  end
  module_function :csv
end

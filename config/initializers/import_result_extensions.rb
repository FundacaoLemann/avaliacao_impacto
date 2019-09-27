module ActiveAdminImport
  class ImportResult
    attr_accessor :ids

    def add(result, qty)
      @ids ||= []
      @ids.concat(result.ids)
      @failed += result.failed_instances
      @total += qty
    end
  end
end

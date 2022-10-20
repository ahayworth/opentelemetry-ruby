# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

require "set"

# A given instrument should be connected to one or more streams.
# The number of streams should be equivalent to:
#
# (n_instruments * (n_matching_views or 1)) * n_metric_readers
#
# Each stream has an aggregation method, which is determined by:
# 1. Choosing the aggregation specified by a view, if it matches
#    the instrument in question.
# 2. Choosing the aggregation method specified by the reader of this
#    stream.
# 3. Falling back to the default aggregation for the metric type.
#
# For synchronous instruments, an instrument emits its metrics
# simultaneously to all appropriate streams.
#
# For asynchronous instruments, nothing is emitted until a specific
# metric_reader is being collected - at that point, the callbacks
# for each instrument are invoked and the results are pushed only
# into the streams for the metric reader in question.
#
# TODO: Make a proper key class for indexing into the streams hash
# TODO: Can we ensure that `reconcile_views` is never called without a lock without deadlocking?
# TODO: Implement `update`
# TODO: Implement `observe`
# TODO: Views
# TODO: De-duplicate data - compute shared aggregate once and send through copies?
# TODO: Explore lock-free designs

module OpenTelemetry
  module SDK
    module Metrics
      module State
        # @api private
        #
        # The MetricStreamManager class provides SDK internal functionality
        # that is not a part of the public API.
        class MetricStreamManager
          # @api private
          def initialize
            @instruments = []
            @metric_readers = []
            @metric_streams = {}

            @mutex = Mutex.new
          end

          # @api private
          def register_instrument(instrument)
            @mutex.synchronize do
              @instruments << instrument
              reconcile_streams
            end
          end

          # @api private
          def register_metric_reader(reader)
            @mutex.synchronize do
              @metric_readers << reader
              reconcile_streams
            end
          end

          # def register_view(view); end

          # @api private
          def reconcile_streams
            new_streams = {}

            @instruments.product(@metric_readers) do |i, m|
              key = [i,m]
              new_streams[key] = @streams[key] || MetricStream.new(i, m)
            end

            @streams = new_streams
          end
        end
      end
    end
  end
end

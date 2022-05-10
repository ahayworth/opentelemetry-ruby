# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: opentelemetry/proto/metrics/experimental/metrics_config_service.proto

require 'google/protobuf'

require 'opentelemetry/proto/resource/v1/resource_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("opentelemetry/proto/metrics/experimental/metrics_config_service.proto", :syntax => :proto3) do
    add_message "opentelemetry.proto.metrics.experimental.MetricConfigRequest" do
      optional :resource, :message, 1, "opentelemetry.proto.resource.v1.Resource"
      optional :last_known_fingerprint, :bytes, 2
    end
    add_message "opentelemetry.proto.metrics.experimental.MetricConfigResponse" do
      optional :fingerprint, :bytes, 1
      repeated :schedules, :message, 2, "opentelemetry.proto.metrics.experimental.MetricConfigResponse.Schedule"
      optional :suggested_wait_time_sec, :int32, 3
    end
    add_message "opentelemetry.proto.metrics.experimental.MetricConfigResponse.Schedule" do
      repeated :exclusion_patterns, :message, 1, "opentelemetry.proto.metrics.experimental.MetricConfigResponse.Schedule.Pattern"
      repeated :inclusion_patterns, :message, 2, "opentelemetry.proto.metrics.experimental.MetricConfigResponse.Schedule.Pattern"
      optional :period_sec, :int32, 3
    end
    add_message "opentelemetry.proto.metrics.experimental.MetricConfigResponse.Schedule.Pattern" do
      oneof :match do
        optional :equals, :string, 1
        optional :starts_with, :string, 2
      end
    end
  end
end

module Opentelemetry
  module Proto
    module Metrics
      module Experimental
        MetricConfigRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("opentelemetry.proto.metrics.experimental.MetricConfigRequest").msgclass
        MetricConfigResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("opentelemetry.proto.metrics.experimental.MetricConfigResponse").msgclass
        MetricConfigResponse::Schedule = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("opentelemetry.proto.metrics.experimental.MetricConfigResponse.Schedule").msgclass
        MetricConfigResponse::Schedule::Pattern = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("opentelemetry.proto.metrics.experimental.MetricConfigResponse.Schedule.Pattern").msgclass
      end
    end
  end
end

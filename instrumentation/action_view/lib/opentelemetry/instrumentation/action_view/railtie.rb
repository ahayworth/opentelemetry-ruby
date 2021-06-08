# frozen_string_literal: true

# Copyright The OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

module OpenTelemetry
  module Instrumentation
    module ActionView
      SUBSCRIPTIONS = %w[
        render_template.action_view
        render_partial.action_view
        render_collection.action_view
      ]

      class Railtie < ::Rails::Railtie
        config.before_initialize do
          OpenTelemetry::Instrumentation::Rails::Instrumentation.instance.install({})
        end

        config.after_initialize do
          SUBSCRIPTIONS.each do |subscription_name|
            subscriber = OpenTelemetry::Instrumentation::Rails::SpanSubscriber.new(
              name: subscription_name,
              tracer: ActionView::Instrumentation.instance.tracer
            )
            ::ActiveSupport::Notifications.notifier.subscribe(subscription_name, subscriber)
          end
        end
      end
    end
  end
end

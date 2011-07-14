# Copyright 2011 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

require 'aws/ec2/collection'
require 'aws/ec2/reserved_instances'
require 'aws/ec2/tagged_collection'

module AWS
  class EC2
    class ReservedInstancesCollection < Collection
      
      include TaggedCollection

      def member_class
        ReservedInstances
      end

      def each &block

        response = filtered_request(:describe_reserved_instances)
        response.reserved_instances_set.each do |item|

          reserved_instance = ReservedInstances.new(
            item.reserved_instances_id,
            :config => config)

          yield(reserved_instance)

        end
      end

    end
  end
end

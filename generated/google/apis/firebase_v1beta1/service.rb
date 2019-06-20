# Copyright 2015 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'google/apis/core/base_service'
require 'google/apis/core/json_representation'
require 'google/apis/core/hashable'
require 'google/apis/errors'

module Google
  module Apis
    module FirebaseV1beta1
      # Firebase Management API
      #
      # The Firebase Management API enables programmatic setup and management of
      #  Firebase projects, including a project's Firebase resources and Firebase apps.
      #
      # @example
      #    require 'google/apis/firebase_v1beta1'
      #
      #    Firebase = Google::Apis::FirebaseV1beta1 # Alias the module
      #    service = Firebase::FirebaseManagementService.new
      #
      # @see https://firebase.google.com
      class FirebaseManagementService < Google::Apis::Core::BaseService
        # @return [String]
        #  API key. Your API key identifies your project and provides you with API access,
        #  quota, and reports. Required unless you provide an OAuth 2.0 token.
        attr_accessor :key

        # @return [String]
        #  Available to use for quota purposes for server-side applications. Can be any
        #  arbitrary string assigned to a user, but should not exceed 40 characters.
        attr_accessor :quota_user

        def initialize
          super('https://firebase.googleapis.com/', '')
          @batch_path = 'batch'
        end
        
        # Returns a list of [Google Cloud Platform (GCP) `Projects`]
        # (https://cloud.google.com/resource-manager/reference/rest/v1/projects)
        # that are available to have Firebase resources added to them.
        # <br>
        # <br>A GCP `Project` will only be returned if:
        # <ol>
        # <li><p>The caller has sufficient
        # [Google IAM](https://cloud.google.com/iam) permissions to call
        # AddFirebase.</p></li>
        # <li><p>The GCP `Project` is not already a FirebaseProject.</p></li>
        # <li><p>The GCP `Project` is not in an Organization which has policies
        # that prevent Firebase resources from being added.</p></li>
        # </ol>
        # @param [Fixnum] page_size
        #   The maximum number of GCP `Projects` to return in the response.
        #   <br>
        #   <br>The server may return fewer than this value at its discretion.
        #   If no value is specified (or too large a value is specified), the server
        #   will impose its own limit.
        #   <br>
        #   <br>This value cannot be negative.
        # @param [String] page_token
        #   Token returned from a previous call to `ListAvailableProjects`
        #   indicating where in the set of GCP `Projects` to resume listing.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::ListAvailableProjectsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::ListAvailableProjectsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_available_projects(page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/availableProjects', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::ListAvailableProjectsResponse::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::ListAvailableProjectsResponse
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the latest state of a long-running operation.  Clients can use this
        # method to poll the operation result at intervals as recommended by the API
        # service.
        # @param [String] name
        #   The name of the operation resource.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_operation(name, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/{+name}', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::Operation::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::Operation
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Adds Firebase resources to the specified existing
        # [Google Cloud Platform (GCP) `Project`]
        # (https://cloud.google.com/resource-manager/reference/rest/v1/projects).
        # <br>
        # <br>Since a FirebaseProject is actually also a GCP `Project`, a
        # `FirebaseProject` uses underlying GCP identifiers (most importantly,
        # the `projectId`) as its own for easy interop with GCP APIs.
        # <br>
        # <br>The result of this call is an [`Operation`](../../v1beta1/operations).
        # Poll the `Operation` to track the provisioning process by calling
        # GetOperation until
        # [`done`](../../v1beta1/operations#Operation.FIELDS.done) is `true`. When
        # `done` is `true`, the `Operation` has either succeeded or failed. If the
        # `Operation` succeeded, its
        # [`response`](../../v1beta1/operations#Operation.FIELDS.response) is set to
        # a FirebaseProject; if the `Operation` failed, its
        # [`error`](../../v1beta1/operations#Operation.FIELDS.error) is set to a
        # google.rpc.Status. The `Operation` is automatically deleted after
        # completion, so there is no need to call
        # DeleteOperation.
        # <br>
        # <br>This method does not modify any billing account information on the
        # underlying GCP `Project`.
        # <br>
        # <br>All fields listed in the [request body](#request-body) are required.
        # <br>
        # <br>To call `AddFirebase`, a member must be an Editor or Owner for the
        # existing GCP `Project`. Service accounts cannot call `AddFirebase`.
        # @param [String] project
        #   The resource name of the GCP `Project` to which Firebase resources will be
        #   added, in the format:
        #   <br><code>projects/<var>projectId</var></code>
        #   After calling `AddFirebase`, the
        #   [`projectId`](https://cloud.google.com/resource-manager/reference/rest/v1/
        #   projects#Project.FIELDS.project_id)
        #   of the GCP `Project` is also the `projectId` of the FirebaseProject.
        # @param [Google::Apis::FirebaseV1beta1::AddFirebaseRequest] add_firebase_request_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def add_project_firebase(project, add_firebase_request_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:post, 'v1beta1/{+project}:addFirebase', options)
          command.request_representation = Google::Apis::FirebaseV1beta1::AddFirebaseRequest::Representation
          command.request_object = add_firebase_request_object
          command.response_representation = Google::Apis::FirebaseV1beta1::Operation::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::Operation
          command.params['project'] = project unless project.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the FirebaseProject identified by the specified resource name.
        # @param [String] name
        #   The fully qualified resource name of the Project, in the format:
        #   <br><code>projects/<var>projectId</var></code>
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::FirebaseProject] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::FirebaseProject]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project(name, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/{+name}', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::FirebaseProject::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::FirebaseProject
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the configuration artifact used by servers to simplify initialization.
        # <br>
        # <br>Typically, this configuration is used with the Firebase Admin SDK
        # [initializeApp](https://firebase.google.com/docs/admin/setup#
        # initialize_the_sdk)
        # command.
        # @param [String] name
        #   The fully qualified resource name of the Project, in the format:
        #   <br><code>projects/<var>projectId</var>/adminSdkConfig</code>
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::AdminSdkConfig] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::AdminSdkConfig]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_admin_sdk_config(name, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/{+name}', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::AdminSdkConfig::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::AdminSdkConfig
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists each FirebaseProject accessible to the caller.
        # <br>
        # <br>The elements are returned in no particular order, but they will be a
        # consistent view of the Projects when additional requests are made with a
        # `pageToken`.
        # <br>
        # <br>This method is eventually consistent with Project mutations, which
        # means newly provisioned Projects and recent modifications to existing
        # Projects might not be reflected in the set of Projects. The list will
        # include only ACTIVE Projects.
        # <br>
        # <br>Use
        # GetFirebaseProject
        # for consistent reads as well as for additional Project details.
        # @param [Fixnum] page_size
        #   The maximum number of Projects to return in the response.
        #   <br>
        #   <br>The server may return fewer than this at its discretion.
        #   If no value is specified (or too large a value is specified), the server
        #   will impose its own limit.
        #   <br>
        #   <br>This value cannot be negative.
        # @param [String] page_token
        #   Token returned from a previous call to `ListFirebaseProjects` indicating
        #   where in the set of Projects to resume listing.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::ListFirebaseProjectsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::ListFirebaseProjectsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_projects(page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/projects', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::ListFirebaseProjectsResponse::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::ListFirebaseProjectsResponse
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the attributes of the FirebaseProject identified by the
        # specified resource name.
        # <br>
        # <br>All [query parameters](#query-parameters) are required.
        # @param [String] name
        #   The fully qualified resource name of the Project, in the format:
        #   <br><code>projects/<var>projectId</var></code>
        # @param [Google::Apis::FirebaseV1beta1::FirebaseProject] firebase_project_object
        # @param [String] update_mask
        #   Specifies which fields to update.
        #   <br>
        #   <br>If this list is empty, then no state will be updated.
        #   <br>Note that the fields `name`, `project_id`, and `project_number` are all
        #   immutable.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::FirebaseProject] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::FirebaseProject]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_project(name, firebase_project_object = nil, update_mask: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:patch, 'v1beta1/{+name}', options)
          command.request_representation = Google::Apis::FirebaseV1beta1::FirebaseProject::Representation
          command.request_object = firebase_project_object
          command.response_representation = Google::Apis::FirebaseV1beta1::FirebaseProject::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::FirebaseProject
          command.params['name'] = name unless name.nil?
          command.query['updateMask'] = update_mask unless update_mask.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # A convenience method that lists all available Apps for the specified
        # FirebaseProject.
        # <br>
        # <br>Typically, interaction with an App should be done using the
        # platform-specific service, but some tool use-cases require a summary of all
        # known Apps (such as for App selector interfaces).
        # @param [String] parent
        #   The parent Project for which to list Apps, in the format:
        #   <br><code>projects/<var>projectId</var></code>
        # @param [Fixnum] page_size
        #   The maximum number of Apps to return in the response.
        #   <br>
        #   <br>The server may return fewer than this value at its discretion.
        #   If no value is specified (or too large a value is specified), then the
        #   server will impose its own limit.
        #   <br>
        #   <br>This value cannot be negative.
        # @param [String] page_token
        #   Token returned from a previous call to `SearchFirebaseApps` indicating
        #   where in the set of Apps to resume listing.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::SearchFirebaseAppsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::SearchFirebaseAppsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def search_project_apps(parent, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/{+parent}:searchApps', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::SearchFirebaseAppsResponse::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::SearchFirebaseAppsResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Requests that a new AndroidApp be created.
        # <br>
        # <br>The result of this call is an `Operation` which can be used to track
        # the provisioning process. The `Operation` is automatically deleted after
        # completion, so there is no need to call `DeleteOperation`.
        # @param [String] parent
        #   The parent Project for which to list Apps, in the format:
        #   <br><code>projects/<var>projectId</var></code>
        # @param [Google::Apis::FirebaseV1beta1::AndroidApp] android_app_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_project_android_app(parent, android_app_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:post, 'v1beta1/{+parent}/androidApps', options)
          command.request_representation = Google::Apis::FirebaseV1beta1::AndroidApp::Representation
          command.request_object = android_app_object
          command.response_representation = Google::Apis::FirebaseV1beta1::Operation::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::Operation
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the AndroidApp identified by the specified resource name.
        # @param [String] name
        #   The fully qualified resource name of the App, in the format:
        #   <br><code>projects/<var>projectId</var>/androidApps/<var>appId</var></code>
        #   <br>As an <var>appId</var> is a unique identifier, the Unique Resource
        #   from Sub-Collection access pattern may be used here, in the format:
        #   <br><code>projects/-/androidApps/<var>appId</var></code>
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::AndroidApp] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::AndroidApp]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_android_app(name, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/{+name}', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::AndroidApp::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::AndroidApp
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the configuration artifact associated with the specified
        # AndroidApp.
        # @param [String] name
        #   The resource name of the App configuration to download, in the format:
        #   <br><code>projects/<var>projectId</var>/androidApps/<var>appId</var>/config</
        #   code>
        #   <br>As an <var>appId</var> is a unique identifier, the Unique Resource
        #   from Sub-Collection access pattern may be used here, in the format:
        #   <br><code>projects/-/androidApps/<var>appId</var></code>
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::AndroidAppConfig] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::AndroidAppConfig]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_android_app_config(name, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/{+name}', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::AndroidAppConfig::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::AndroidAppConfig
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists each AndroidApp associated with the specified parent Project.
        # <br>
        # <br>The elements are returned in no particular order, but will be a
        # consistent view of the Apps when additional requests are made with a
        # `pageToken`.
        # @param [String] parent
        #   The parent Project for which to list Apps, in the format:
        #   <br><code>projects/<var>projectId</var></code>
        # @param [Fixnum] page_size
        #   The maximum number of Apps to return in the response.
        #   <br>
        #   <br>The server may return fewer than this at its discretion.
        #   If no value is specified (or too large a value is specified), then the
        #   server will impose its own limit.
        # @param [String] page_token
        #   Token returned from a previous call to `ListAndroidApps` indicating where
        #   in the set of Apps to resume listing.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::ListAndroidAppsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::ListAndroidAppsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_project_android_apps(parent, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/{+parent}/androidApps', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::ListAndroidAppsResponse::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::ListAndroidAppsResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the attributes of the AndroidApp identified by the specified
        # resource name.
        # @param [String] name
        #   The fully qualified resource name of the App, in the format:
        #   <br><code>projects/<var>projectId</var>/androidApps/<var>appId</var></code>
        # @param [Google::Apis::FirebaseV1beta1::AndroidApp] android_app_object
        # @param [String] update_mask
        #   Specifies which fields to update.
        #   <br>Note that the fields `name`, `appId`, `projectId`, and `packageName`
        #   are all immutable.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::AndroidApp] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::AndroidApp]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_project_android_app(name, android_app_object = nil, update_mask: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:patch, 'v1beta1/{+name}', options)
          command.request_representation = Google::Apis::FirebaseV1beta1::AndroidApp::Representation
          command.request_object = android_app_object
          command.response_representation = Google::Apis::FirebaseV1beta1::AndroidApp::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::AndroidApp
          command.params['name'] = name unless name.nil?
          command.query['updateMask'] = update_mask unless update_mask.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Adds a SHA certificate to the specified AndroidApp.
        # @param [String] parent
        #   The parent App to which a SHA certificate will be added, in the format:
        #   <br><code>projects/<var>projectId</var>/androidApps/<var>appId</var></code>
        #   <br>As an <var>appId</var> is a unique identifier, the Unique Resource
        #   from Sub-Collection access pattern may be used here, in the format:
        #   <br><code>projects/-/androidApps/<var>appId</var></code>
        # @param [Google::Apis::FirebaseV1beta1::ShaCertificate] sha_certificate_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::ShaCertificate] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::ShaCertificate]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_project_android_app_sha(parent, sha_certificate_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:post, 'v1beta1/{+parent}/sha', options)
          command.request_representation = Google::Apis::FirebaseV1beta1::ShaCertificate::Representation
          command.request_object = sha_certificate_object
          command.response_representation = Google::Apis::FirebaseV1beta1::ShaCertificate::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::ShaCertificate
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Removes a SHA certificate from the specified AndroidApp.
        # @param [String] name
        #   The fully qualified resource name of the `sha-key`, in the format:
        #   <br><code>projects/<var>projectId</var>/androidApps/<var>appId</var>/sha/<var>
        #   shaHash</var></code>
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::Empty] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::Empty]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def delete_project_android_app_sha(name, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:delete, 'v1beta1/{+name}', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::Empty::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::Empty
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Returns the list of SHA-1 and SHA-256 certificates for the specified
        # AndroidApp.
        # @param [String] parent
        #   The parent App for which to list SHA certificates, in the format:
        #   <br><code>projects/<var>projectId</var>/androidApps/<var>appId</var></code>
        #   <br>As an <var>appId</var> is a unique identifier, the Unique Resource
        #   from Sub-Collection access pattern may be used here, in the format:
        #   <br><code>projects/-/androidApps/<var>appId</var></code>
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::ListShaCertificatesResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::ListShaCertificatesResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_project_android_app_shas(parent, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/{+parent}/sha', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::ListShaCertificatesResponse::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::ListShaCertificatesResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Requests that a new IosApp be created.
        # <br>
        # <br>The result of this call is an `Operation` which can be used to track
        # the provisioning process. The `Operation` is automatically deleted after
        # completion, so there is no need to call `DeleteOperation`.
        # @param [String] parent
        #   The parent Project for which to list Apps, in the format:
        #   <br><code>projects/<var>projectId</var></code>
        # @param [Google::Apis::FirebaseV1beta1::IosApp] ios_app_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_project_ios_app(parent, ios_app_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:post, 'v1beta1/{+parent}/iosApps', options)
          command.request_representation = Google::Apis::FirebaseV1beta1::IosApp::Representation
          command.request_object = ios_app_object
          command.response_representation = Google::Apis::FirebaseV1beta1::Operation::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::Operation
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the IosApp identified by the specified resource name.
        # @param [String] name
        #   The fully qualified resource name of the App, in the format:
        #   <code>projects/<var>projectId</var>/iosApps/<var>appId</var></code>
        #   <br>As an <var>appId</var> is a unique identifier, the Unique Resource
        #   from Sub-Collection access pattern may be used here, in the format:
        #   <br><code>projects/-/iosApps/<var>appId</var></code>
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::IosApp] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::IosApp]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_ios_app(name, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/{+name}', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::IosApp::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::IosApp
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the configuration artifact associated with the specified IosApp.
        # @param [String] name
        #   The resource name of the App configuration to download, in the format:
        #   <br><code>projects/<var>projectId</var>/iosApps/<var>appId</var>/config</code>
        #   <br>As an <var>appId</var> is a unique identifier, the Unique Resource
        #   from Sub-Collection access pattern may be used here, in the format:
        #   <br><code>projects/-/iosApps/<var>appId</var></code>
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::IosAppConfig] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::IosAppConfig]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_ios_app_config(name, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/{+name}', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::IosAppConfig::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::IosAppConfig
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists each IosApp associated with the specified parent Project.
        # <br>
        # <br>The elements are returned in no particular order, but will be a
        # consistent view of the Apps when additional requests are made with a
        # `pageToken`.
        # @param [String] parent
        #   The parent Project for which to list Apps, in the format:
        #   <br><code>projects/<var>projectId</var></code>
        # @param [Fixnum] page_size
        #   The maximum number of Apps to return in the response.
        #   <br>
        #   <br>The server may return fewer than this at its discretion.
        #   If no value is specified (or too large a value is specified), the server
        #   will impose its own limit.
        # @param [String] page_token
        #   Token returned from a previous call to `ListIosApps` indicating where in
        #   the set of Apps to resume listing.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::ListIosAppsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::ListIosAppsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_project_ios_apps(parent, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/{+parent}/iosApps', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::ListIosAppsResponse::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::ListIosAppsResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the attributes of the IosApp identified by the specified
        # resource name.
        # @param [String] name
        #   The fully qualified resource name of the App, in the format:
        #   <br><code>projects/<var>projectId</var>/iosApps/<var>appId</var></code>
        # @param [Google::Apis::FirebaseV1beta1::IosApp] ios_app_object
        # @param [String] update_mask
        #   Specifies which fields to update.
        #   <br>Note that the fields `name`, `appId`, `projectId`, and `bundleId`
        #   are all immutable.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::IosApp] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::IosApp]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_project_ios_app(name, ios_app_object = nil, update_mask: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:patch, 'v1beta1/{+name}', options)
          command.request_representation = Google::Apis::FirebaseV1beta1::IosApp::Representation
          command.request_object = ios_app_object
          command.response_representation = Google::Apis::FirebaseV1beta1::IosApp::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::IosApp
          command.params['name'] = name unless name.nil?
          command.query['updateMask'] = update_mask unless update_mask.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Requests that a new WebApp be created.
        # <br>
        # <br>The result of this call is an `Operation` which can be used to track
        # the provisioning process. The `Operation` is automatically deleted after
        # completion, so there is no need to call `DeleteOperation`.
        # @param [String] parent
        #   The parent Project for which to list Apps, in the format:
        #   <br><code>projects/<var>projectId</var></code>
        # @param [Google::Apis::FirebaseV1beta1::WebApp] web_app_object
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::Operation] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::Operation]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def create_project_web_app(parent, web_app_object = nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:post, 'v1beta1/{+parent}/webApps', options)
          command.request_representation = Google::Apis::FirebaseV1beta1::WebApp::Representation
          command.request_object = web_app_object
          command.response_representation = Google::Apis::FirebaseV1beta1::Operation::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::Operation
          command.params['parent'] = parent unless parent.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the WebApp identified by the specified resource name.
        # @param [String] name
        #   The fully qualified resource name of the App, in the format:
        #   <br><code>projects/<var>projectId</var>/webApps/<var>appId</var></code>
        #   <br>As an <var>appId</var> is a unique identifier, the Unique Resource
        #   from Sub-Collection access pattern may be used here, in the format:
        #   <br><code>projects/-/webApps/<var>appId</var></code>
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::WebApp] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::WebApp]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_web_app(name, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/{+name}', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::WebApp::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::WebApp
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Gets the configuration artifact associated with the specified WebApp.
        # @param [String] name
        #   The resource name of the App configuration to download, in the format:
        #   <br><code>projects/<var>projectId</var>/webApps/<var>appId</var>/config</code>
        #   <br>As an <var>appId</var> is a unique identifier, the Unique Resource
        #   from Sub-Collection access pattern may be used here, in the format:
        #   <br><code>projects/-/webApps/<var>appId</var></code>
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::WebAppConfig] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::WebAppConfig]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def get_project_web_app_config(name, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/{+name}', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::WebAppConfig::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::WebAppConfig
          command.params['name'] = name unless name.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Lists each WebApp associated with the specified parent Project.
        # <br>
        # <br>The elements are returned in no particular order, but will be a
        # consistent view of the Apps when additional requests are made with a
        # `pageToken`.
        # @param [String] parent
        #   The parent Project for which to list Apps, in the format:
        #   <br><code>projects/<var>projectId</var></code>
        # @param [Fixnum] page_size
        #   The maximum number of Apps to return in the response.
        #   <br>
        #   <br>The server may return fewer than this value at its discretion.
        #   If no value is specified (or too large a value is specified), then the
        #   server will impose its own limit.
        # @param [String] page_token
        #   Token returned from a previous call to `ListWebApps` indicating where in
        #   the set of Apps to resume listing.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::ListWebAppsResponse] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::ListWebAppsResponse]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def list_project_web_apps(parent, page_size: nil, page_token: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:get, 'v1beta1/{+parent}/webApps', options)
          command.response_representation = Google::Apis::FirebaseV1beta1::ListWebAppsResponse::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::ListWebAppsResponse
          command.params['parent'] = parent unless parent.nil?
          command.query['pageSize'] = page_size unless page_size.nil?
          command.query['pageToken'] = page_token unless page_token.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end
        
        # Updates the attributes of the WebApp identified by the specified
        # resource name.
        # @param [String] name
        #   The fully qualified resource name of the App, for example:
        #   <br><code>projects/<var>projectId</var>/webApps/<var>appId</var></code>
        # @param [Google::Apis::FirebaseV1beta1::WebApp] web_app_object
        # @param [String] update_mask
        #   Specifies which fields to update.
        #   <br>Note that the fields `name`, `appId`, and `projectId` are all
        #   immutable.
        # @param [String] fields
        #   Selector specifying which fields to include in a partial response.
        # @param [String] quota_user
        #   Available to use for quota purposes for server-side applications. Can be any
        #   arbitrary string assigned to a user, but should not exceed 40 characters.
        # @param [Google::Apis::RequestOptions] options
        #   Request-specific options
        #
        # @yield [result, err] Result & error if block supplied
        # @yieldparam result [Google::Apis::FirebaseV1beta1::WebApp] parsed result object
        # @yieldparam err [StandardError] error object if request failed
        #
        # @return [Google::Apis::FirebaseV1beta1::WebApp]
        #
        # @raise [Google::Apis::ServerError] An error occurred on the server and the request can be retried
        # @raise [Google::Apis::ClientError] The request is invalid and should not be retried without modification
        # @raise [Google::Apis::AuthorizationError] Authorization is required
        def patch_project_web_app(name, web_app_object = nil, update_mask: nil, fields: nil, quota_user: nil, options: nil, &block)
          command = make_simple_command(:patch, 'v1beta1/{+name}', options)
          command.request_representation = Google::Apis::FirebaseV1beta1::WebApp::Representation
          command.request_object = web_app_object
          command.response_representation = Google::Apis::FirebaseV1beta1::WebApp::Representation
          command.response_class = Google::Apis::FirebaseV1beta1::WebApp
          command.params['name'] = name unless name.nil?
          command.query['updateMask'] = update_mask unless update_mask.nil?
          command.query['fields'] = fields unless fields.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
          execute_or_queue_command(command, &block)
        end

        protected

        def apply_command_defaults(command)
          command.query['key'] = key unless key.nil?
          command.query['quotaUser'] = quota_user unless quota_user.nil?
        end
      end
    end
  end
end

//
// Copyright (c) 2026 Couchbase, Inc.  All rights reserved.
//
// Licensed under the Couchbase License Agreement (the "License");
// you may not use this file except in compliance with the License.
// You may review the License at
// https://www.couchbase.com/enterprise-terms
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

// Plugin versions and dependency versions are centralized in gradle/libs.versions.toml.
// Plugin resolution is configured via pluginManagement in settings.gradle.kts.

tasks.register("devPublish") {
    dependsOn(
        ":ce:android:ce_android:devPublish",
        ":ce:android-ktx:ce_android-ktx:devPublish",
        ":ce:java:ce_java:devPublish"
    )
}

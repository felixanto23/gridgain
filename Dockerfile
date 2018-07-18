#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Start from Oracle Linux 8 based on Alpine Linux image (~5Mb)


FROM oraclelinux
USER ROOT
# Set Product name
ENV PRODUCT gridgain
# Set GridGain version
ENV GRIDGAIN_VERSION 8.4.5
# Set GridGain edition
ENV GRIDGAIN_EDITION enterprise
# Set Ignite binary name
ENV GRIDGAIN_BIN ${PRODUCT}-${GRIDGAIN_EDITION}-fabric-${GRIDGAIN_VERSION}
# Set Ignite home directory
ENV IGNITE_HOME /opt/${PRODUCT}/${GRIDGAIN_BIN}

# Set working directory
WORKDIR /opt/${PRODUCT}

# Add missing software
RUN yum update -y && \
    yum install zip unzip wget jre -y

# Get binary archive
RUN set -x && \
    wget -c "https://gridgain.com/media/${GRIDGAIN_BIN}.zip" -O gridgain.zip && \
    unzip gridgain.zip && \
    rm -rfv gridgain.zip


ADD https://github.com/felixanto23/gridgain/tree/master/config/gridgain-license.xml ${IGNITE_HOME}/
ADD https://github.com/felixanto23/gridgain/tree/master/config/data-node-log4j.xml  ${IGNITE_HOME}/
ADD https://github.com/felixanto23/gridgain/tree/master/config/multiplan-ucw-cluster-config.xml ${IGNITE_HOME}/config
ADD https://github.com/felixanto23/gridgain/tree/master/config/multiplan-ucw-DEV-cluster-config.xml ${IGNITE_HOME}/config
ADD https://github.com/felixanto23/gridgain/tree/master/config/multiplan-ucw-SQA-cluster-config.xml ${IGNITE_HOME}/config
ADD https://github.com/felixanto23/gridgain/tree/master/config/multiplan-ucw-PROD-cluster-config.xml ${IGNITE_HOME}/config
ADD https://github.com/felixanto23/gridgain/tree/master/config/startIgnite.sh ${IGNITE_HOME}/

# Copy sh files and set permission
CMD ${IGNITE_HOME}/startIgnite.sh $ENV $NODE

EXPOSE 11211 47100 47500 49112

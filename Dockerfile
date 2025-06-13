FROM neo4j:latest

# Environmental variables for configuration
ENV NEO4J_AUTH=neo4j/password \
    NEO4J_dbms_memory_heap_initial__size=512m \
    NEO4J_dbms_memory_heap_max__size=2G \
    NEO4J_dbms_memory_pagecache_size=512m

# Expose the necessary ports
# - 7474: HTTP
# - 7473: HTTPS
# - 7687: Bolt
EXPOSE 7474 7473 7687

# Health check to ensure Neo4j is running
HEALTHCHECK --interval=30s --timeout=30s --retries=3 \
  CMD wget -O /dev/null -q http://localhost:7474 || exit 1

# Volume for data persistence
VOLUME /data

# Set the entrypoint to the default Neo4j entrypoint
ENTRYPOINT ["tini", "-g", "--", "/startup/docker-entrypoint.sh"]
CMD ["neo4j"]

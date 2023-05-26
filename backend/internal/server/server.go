package server

import (
	"context"
	"github.com/gofiber/fiber/v2"
	"net/http"
	_ "net/http/pprof"
	"os"
	"os/signal"
	"syscall"
	"time"

	"backend/config"
	_ "backend/docs"
	"backend/pkg/logger"
	"github.com/go-redis/redis/v8"
	"github.com/jmoiron/sqlx"
)

const (
	certFile = "ssl/Server.crt"
	keyFile  = "ssl/Server.pem"
	//maxHeaderBytes = 1 << 20
	ctxTimeout = 5
)

// Server struct
type Server struct {
	fiber       *fiber.App
	cfg         *config.Config
	db          *sqlx.DB
	redisClient *redis.Client
	//awsClient   *minio.Client
	logger logger.Logger
}

// NewServer New Server constructor
func NewServer(cfg *config.Config, db *sqlx.DB, redisClient *redis.Client, logger logger.Logger) *Server {
	return &Server{fiber: fiber.New(), cfg: cfg, db: db, redisClient: redisClient, logger: logger}
}

func (s *Server) Run() error {
	//Server is configured to use SSL
	if s.cfg.Server.SSL {
		if err := s.MapHandlers(s.fiber); err != nil {
			return err
		}

		s.fiber.Server().ReadTimeout = time.Second * s.cfg.Server.ReadTimeout
		s.fiber.Server().WriteTimeout = time.Second * s.cfg.Server.WriteTimeout

		go func() {
			s.logger.Infof("Server is listening on PORT: %s", s.cfg.Server.Port)
			s.fiber.Server().ReadTimeout = time.Second * s.cfg.Server.ReadTimeout
			s.fiber.Server().WriteTimeout = time.Second * s.cfg.Server.WriteTimeout

			//cer, _ := tls.LoadX509KeyPair(certFile, keyFile)
			//
			//// Create tls certificate
			//tlsConfig := &tls.Config{
			//	Certificates: []tls.Certificate{cer},
			//}
			//
			//// Create custom listener
			//ln, err := tls.Listen("tcp", s.cfg.Server.Port, tlsConfig)
			//if err != nil {
			//	s.logger.Fatalf("Error create custom listener: ", err)
			//}
			//
			//// Start server with https/ssl enabled on http://localhost:{Port}
			//if err := s.fiber.Listener(ln); err != nil {
			//	s.logger.Fatalf("Error starting TLS Server: ", err)
			//}

			if err := s.fiber.ListenTLS(s.cfg.Server.Port, certFile, keyFile); err != nil {
				s.logger.Fatalf("Error starting TLS Server: ", err)

			}
		}()

		quit := make(chan os.Signal, 1)
		signal.Notify(quit, os.Interrupt, syscall.SIGTERM)

		<-quit

		ctx, shutdown := context.WithTimeout(context.Background(), ctxTimeout*time.Second)
		defer shutdown()

		s.logger.Info("Server Exited Properly")
		return s.fiber.Server().ShutdownWithContext(ctx)
	}

	//Server is not configured to use SSL
	//server := &fiber.Config{
	//	ServerHeader: "Fiber",
	//	ReadTimeout:  time.Second * s.cfg.Server.ReadTimeout,
	//	WriteTimeout: time.Second * s.cfg.Server.WriteTimeout,
	//}

	if err := s.MapHandlers(s.fiber); err != nil {
		return err
	}

	s.fiber.Server().ReadTimeout = time.Second * s.cfg.Server.ReadTimeout
	s.fiber.Server().WriteTimeout = time.Second * s.cfg.Server.WriteTimeout

	go func() {
		s.logger.Infof("Server is listening on PORT: %s", s.cfg.Server.Port)
		if err := s.fiber.Listen(s.cfg.Server.Port); err != nil {
			s.logger.Fatalf("Error starting Server: ", err)
		}
	}()

	go func() {
		s.logger.Infof("Starting Debug Server on PORT: %s", s.cfg.Server.PprofPort)
		if err := http.ListenAndServe(s.cfg.Server.PprofPort, http.DefaultServeMux); err != nil {
			s.logger.Errorf("Error PPROF ListenAndServe: %s", err)
		}
	}()

	quit := make(chan os.Signal, 1)
	signal.Notify(quit, os.Interrupt, syscall.SIGTERM)

	<-quit

	ctx, shutdown := context.WithTimeout(context.Background(), ctxTimeout*time.Second)
	defer shutdown()

	s.logger.Info("Server Exited Properly")
	return s.fiber.Server().ShutdownWithContext(ctx)
}

from subprocess import check_output
import os


here = os.path.abspath(os.path.dirname(__file__))


class Job:
    def __init__(self, name='', config_file=''):
        self.name = name
        self.config_file = config_file


def output_shell(cmd):
    os.chdir(here)
    return check_output(cmd)


def _jobs():
    job_dirs = os.listdir(here)
    jobs = []
    for job_dir in job_dirs:
        if not os.path.isdir(job_dir) or not job_dir.startswith('lain'):
            continue
        jobs.append(Job(job_dir, os.path.join(job_dir, 'config.xml')))
    return jobs


def create_jobs(server):
    jobs =  _jobs()
    for job in jobs:
        try :
            with open(job.config_file, 'r') as config_file:
                config = config_file.read()
            server.create_job(job.name, config)
            print 'create job %s successed' % job.name
        except Exception as e:
            print 'create job %s failed' % job.name
            try :
                server.reconfig_job(job.name, config)
                print 'reconfig job %s successed' % job.name
            except Exception as e:
                print 'reconfig job %s failed' % job.name
        